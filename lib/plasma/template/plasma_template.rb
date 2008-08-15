module Plasma
  module Template
    class PlasmaTemplate
      attr_accessor :plasma

      @@separator = /\|\|/

      def self.parse(template)
        return PlasmaTemplate.new(template)
      end

      def initialize(template)
        @template = template
        @plasma = Plasma::Interpreter::PlasmaInterpreter.new

        @plain = []
        @plasmic = []

        cursor = @template

        loop do 
          pre = cursor.match(@@separator)
          
          if pre.nil?
            @plain << cursor
            break
          else
            @plain << pre.pre_match
            code = pre.values_at(0)[0]
            post = pre.post_match.match(@@separator)

            if post.nil?
              @plain << pre.post_match
              break
            else
              code += post.pre_match + post.values_at(0)[0]
              cursor = post.post_match

              @plasmic << @plasma.parse(code)
            end
          end
        end
      end

      def render(rel={})
        @plasma.env.merge!(rel)
        evaluated = @plasmic.map{|p| @plasma.evaluate(p)}

        rendered = ''
        @plain.slice(0...@plain.length-1).each_with_index do |text, index|
          portion = text + evaluated[index].to_s
          rendered += portion
        end

        return rendered + @plain.last
      end
    end
  end
end
