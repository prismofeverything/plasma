module Plasma
  module Interpreter
    class Env
      attr_accessor :state
      attr_accessor :default

      def initialize(init={}, default=nil)
        @state = [init]
        @default = default
      end

      def to_s
        @state.map {|s| s.inspect}.join("\n")
      end

      def to_plasma
        @state.to_plasma
      end

      def bind!(key, value)
        @state.last[key] = value
        self
      end

      def merge!(hash)
        @state.last.merge!(hash)
        self
      end

      def scope!(inner={})
        @state.push(inner)
        self
      end

      def release!()
        @state.pop
        self
      end

      def scope(inner={})
        self.scope!(inner)

        begin
          value = yield self
          self.release!

          return value
        rescue => detail
          self.release!
          detail
        end
      end

      def resolve(key)
        @state.reverse_each do |layer|
          return layer[key] if layer.include?(key)
        end

        # nothing to find
        return default
      end
    end

    class Quote
      attr_reader :unevaluated

      def initialize(plasma)
        @unevaluated = plasma
      end

      def unquote(env)
        @unevaluated.evaluate(env)
      end

      def to_plasma
        "`#{@unevaluated.text_value}'"
      end
    end

    class Closure
      attr_reader :env, :params, :body

      def initialize(env, params, body)
        @env = env.dup
        @params = params
        @body = body
        @proc = nil
      end

      def apply(*args)
        left = params.dup
        args = args.slice(0...left.length) if left.length < args.length
        zipped = args.inject({}){|hash, arg| hash.merge(left.shift => arg)}
        zipped.merge!(:env => @env)

        if left.empty?
          @env.scope(zipped) do |env|
            @body.evaluate(env)
          end
        else
          return Closure.new(@env.dup.merge!(zipped), left, body)
        end
      end

      def to_proc
        @proc ||= Proc.new do |*args|
          self.apply *args
        end
      end

      def to_plasma
        p = params.map{|p| p.to_s}.join(' ')
        "fun (#{p}) #{@body.text_value}"
      end
    end

    class RubyClosure
      def initialize(name, interp, &body)
        @name = name
        @interp = interp
        @body = Proc.new(&body)
      end

      def apply(*args)
        args = args.slice(0..@body.arity) if @body.arity < args.length
        diff = @body.arity - args.length
        if diff == 0
          value = @body.call(*args)
        else
          fresh = {}
          args.each_with_index {|arg, index| fresh.merge(index => arg)}
          params = (args.length..args.length+diff).join(' ')
          keys = fresh.keys.join(' ')
          env = Env.new(fresh.merge(@name => self))

          interp.interpret("fun (#{params}) (#{@name} #{keys} #{params})", env)
        end
      end
    end

    class UnresolvedSymbolException < Exception
      attr_accessor :symbol

      def initialize(symbol)
        @symbol = symbol
      end
    end

    class NoSuchSourceException < Exception
      attr_accessor :plasma

      def initialize(plasma)
        @plasma = plasma
      end
    end

    class TooManyArgumentsException < Exception
    end

    class FailedToParseException < Exception
    end

    class PlasmaNode < Treetop::Runtime::SyntaxNode
      def evaluate(env)
        orb.evaluate(env)
      end

      def empty?
        false
      end
    end

    class ColNode < PlasmaNode
      def col
        if first.empty?
          []
        else
          if rest.empty?
            [first]
          else
            rest.elements.map do |el|
              el.elements.select{|subel| subel.is_a? PlasmaNode}
            end.flatten.unshift(first)
          end
        end
      end
    end

    class Treetop::Runtime::SyntaxNode
      def to_s
        text_value
      end
    end

    class TemplateNode < PlasmaNode
      def evaluate(env)
        value = body.empty? ? '' : body.elements.inject('') do |so_far, el|
          macro_value = el.macro.is_a?(ExpansionNode) ? el.macro.evaluate(env).to_s : el.macro.text_value
          tail_value = el.respond_to?(:tail) ? el.tail.text_value : ''

          so_far + macro_value + tail_value
        end
        head.text_value + value
      end
    end

    class PlainNode < PlasmaNode
      def evaluate(env)
        self.text_value
      end
    end

    class QuoteNode < PlasmaNode
      def evaluate(env)
        template.evaluate(env)
      end
    end

    class ExpansionNode < PlasmaNode
      def evaluate(env)
        plasma.evaluate(env)
      end
    end

    class DeclNode < ColNode
      def evaluate(env)
        col.inject(nil) do |value, statement|
          statement.evaluate(env)
        end
      end
    end

    class SeqNode < ColNode
      def evaluate(env)
        env.scope do |env|
          col.inject(nil) do |value, statement|
            statement.evaluate(env)
          end
        end
      end
    end

    class DefunNode < PlasmaNode
      def evaluate(env)
        syms = params.syms
        closure = Closure.new(env, syms.slice(1..syms.length), plasma)
        closure.env.merge!(syms[0] => closure)
        env.bind!(syms[0], closure)
        ''
      end
    end

    class DefNode < PlasmaNode
      def evaluate(env)
        value = plasma.evaluate(env)
        env.bind!(sym.text_value.to_sym, value)
        ''
      end
    end

    class FunNode < PlasmaNode
      def evaluate(env)
        Closure.new(env, params.syms, plasma)
      end
    end

    class ParamsNode < ColNode
      def syms
        col.map{|node| node.text_value.to_sym}
      end
    end

    class IfNode < PlasmaNode
      def evaluate(env)
        if pred.evaluate(env)
          body.evaluate(env)
        elsif respond_to?(:maybe)
          maybe.other.evaluate(env)
        else
          nil
        end
      end
    end

    class ApplyNode < ColNode
      def evaluate(env)
        args = col.map{|arg| arg.evaluate(env)}

        begin
          closure = applied.evaluate(env)
          return closure.apply(*args)
        rescue UnresolvedSymbolException => detail
          begin
            return args.first.send(detail.symbol, *args.slice(1..args.length))
          rescue ArgumentError => arg
            begin
              slice = args.slice(1...args.length-1)
              proc = args.last.to_proc

              return args.first.send(detail.symbol, *slice, &proc)
            rescue Exception => brg
              raise TooManyArgumentsException.new(self.text_value), "too many arguments in #{self.text_value}", caller
            end
          end
        end
      end
    end

    class TrueNode < PlasmaNode
      def evaluate(env)
        true
      end
    end

    class FalseNode < PlasmaNode
      def evaluate(env)
        false
      end
    end

    class SymNode < PlasmaNode
      def evaluate(env)
        result = env.resolve(self.text_value.to_sym)
        raise UnresolvedSymbolException.new(self.text_value), "unresolved symbol #{self.text_value}", caller if result.nil?
        result
      end
    end

    class HashNode < ColNode
      def evaluate(env)
        col.inject({}) {|hash, el| hash.merge(el.evaluate(env))}
      end
    end

    class RelationNode < PlasmaNode
      def evaluate(env)
        {sym.text_value.to_sym => plasma.evaluate(env)}
      end
    end

    class ListNode < ColNode
      def evaluate(env)
        col.map{|el| el.evaluate(env)}
      end
    end

    class RegexNode < PlasmaNode
      def evaluate(env)
        Regexp.new(body.text_value)
      end
    end

    class DateNode < PlasmaNode
      def evaluate(env)
      end
    end

    class TimeNode < PlasmaNode
      def evaluate(env)
      end
    end

    class StrNode < PlasmaNode
      def evaluate(env)
        body.text_value
      end
    end

    class NumNode < PlasmaNode
      def evaluate(env)
        if self.respond_to?(:decimal)
          text_value.to_f
        else
          text_value.to_i
        end
      end
    end
  end
end

