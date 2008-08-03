module Plasma
  module Interpreter
    class PlasmaCore
      def self.plasma(interp)
        {
          :import => RubyClosure.new('import', interp) do |plasma|
            interp.merge("#{plasma}.psm")
          end,

          :print => RubyClosure.new('print', interp) do |string|
            puts string
          end
        }
      end
    end
  end
end


