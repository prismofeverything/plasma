module Plasma
  class PlasmaEngine
    def self.compile_template(io, name, mod)
      path = File.expand_path(io.path)
      code = io.read.gsub(/"/, '\"')
      plasma = <<-interpret
        def #{name}
          Plasma::Interpreter.interpret("#{code}")
        end
      interpret

      m = mod.is_a?(Module) ? :module_eval : :instance_eval
      mod.__send__(m, plasma, path || '(plasma)')
    end

    module Mixin
    end
  end
end
