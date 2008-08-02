load 'plasmanode.rb'
load 'plasma.rb'

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

      interp.interpret("fun (#{params}) ((#{@name} #{keys} #{params}))", env)
    end
  end
end

