class Object
  def to_plasma
    self
  end
end

class String
  def classify
    self.split('_').map{|s| s.capitalize}.join
  end

  def to_plasma
    self.inspect
  end
end

class Array
  def to_hash
    hash = {}
    self.each {|key, value| hash[key] = value}

    return hash
  end

  def to_plasma
    plasma = self.map do |p|
      p.to_plasma
    end.join ' '

    return "[#{plasma}]"
  end
end

class Hash
  def to_plasma
    plasma = self.map do |key, value|
      "#{key.to_s}:#{value.to_plasma}"
    end.join ' '

    return "{#{plasma}}"
  end
end

