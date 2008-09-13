class PlasmaView
  def initialize(action_view)
    @action_view = action_view
  end

  def render(template, local_assigns)
    @action_view.controller.headers["Content-Type"] ||= 'text/html; charset=utf-8'
    assigns = @action_view.assigns.dup
    
    if content_for_layout = @action_view.instance_variable_get("@content_for_layout")
      assigns['content_for_layout'] = content_for_layout
    end
    assigns.merge!(local_assigns)
    
    plasma = Plasma::Interpreter::PlasmaGrammarParser.new
    env = Plasma::Interpreter::Env.new(assigns)

    tree = plasma.parse(template)
    tree.evaluate(env)
  end
end


###
###   33 + 888 * 38838 = 34488177
###
