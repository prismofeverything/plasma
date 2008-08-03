class Array
  def to_hash
    hash = {}
    self.each {|key, value| hash[key] = value}

    return hash
  end
end

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

  def resolve(key)
    @state.reverse.each do |layer|
      return layer[key] if layer.keys.include?(key)
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
    @unevaluated.eval(env)
  end
end

class Closure
  attr_reader :env, :params, :body

  def initialize(env, params, body)
    @env = env.dup
    @params = params
    @body = body
  end

  def apply(*args)
    left = params.dup
    args = args.slice(0...left.length) if left.length < args.length
    zipped = args.inject({}){|hash, arg| hash.merge(left.shift => arg)}
    zipped.merge!(:env => @env)

    if left.empty?
      @env.scope!(zipped)
      value = @body.evaluate(@env)
      @env.release!()

      return value
    else
      return Closure.new(@env.dup.merge!(zipped), left, body)
    end
  end
end

class UnresolvedSymbolException < Exception
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end
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

class DeclNode < ColNode
  def evaluate(env)
    value = col.inject(nil) do |value, statement|
      statement.evaluate(env)
    end
    value
  end
end

class SeqNode < ColNode
  def evaluate(env)
    env.scope!
    value = col.inject(nil) do |value, statement|
      statement.evaluate(env)
    end
    env.release!

    value
  end
end

class QuoteNode < PlasmaNode
  def evaluate(env)
    plasma
  end
end

class DefunNode < PlasmaNode
  def evaluate(env)
    syms = params.syms
    closure = Closure.new(env, syms.slice(1..syms.length), plasma)
    closure.env.merge!(syms[0] => closure)
    env.bind!(syms[0], closure)
  end
end

class DefNode < PlasmaNode
  def evaluate(env)
    env.bind!(sym.text_value.to_sym, plasma.evaluate(env))
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

class ApplyNode < ColNode
  def evaluate(env)
    args = col.map{|arg| arg.evaluate(env)}

    begin
      closure = applied.evaluate(env)
      closure.apply(*args)
    rescue UnresolvedSymbolException => detail
      args.first.send(detail.symbol, *args.slice(1..args.length))
    end
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

class DateNode < PlasmaNode
  def evaluate(env)
  end
end

class TimeNode < PlasmaNode
  def evaluate(env)
  end
end

class StrNode < ColNode
  def evaluate(env)
    self.text_value.slice(1...self.text_value.length-1)
  end
end

class NumNode < PlasmaNode
  def evaluate(env)
    text_value.to_f
  end
end


