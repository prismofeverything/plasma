require 'lib/plasma.rb'

template = File.open(File.join(PLASMA_TEST, "template_test.plasma")).read
plasma = Plasma::Template::PlasmaTemplate.parse(template)

puts plasma.render()
