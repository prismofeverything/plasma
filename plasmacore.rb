load 'plasmanode.rb'
load 'rubyplasma.rb'

class Plasmacore
  def self.plasma(interp)
    {
      :yaow => RubyClosure.new('yaow', interp) do |okay|
        okay * 3
      end,

      :import => RubyClosure.new('import', interp) do |plasma|
        interp.merge("#{plasma}.psm")
      end,

      :print => RubyClosure.new('print', interp) do |string|
        puts string
      end
    }
  end
end



