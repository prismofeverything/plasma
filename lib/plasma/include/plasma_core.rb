module Plasma
  module Interpreter
    class PlasmaCore
      def self.plasma(interp)
        {
          :import => RubyClosure.new('import', interp) do |plasma|
            interp.merge(plasma)
          end,

          :print => RubyClosure.new('print', interp) do |string|
            puts string
          end,

          :eval => RubyClosure.new('eval', interp) do |quote|
            if quote.is_a?(String)
              interp.interpret(quote)
            else
              interp.evaluate(quote)
            end
          end
        }
      end
    end
  end
end


