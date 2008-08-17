require 'lib/plasma.rb'

plasma = Plasma::Interpreter::PlasmaGrammarParser.new

decl = "[| `eiii' | 1233333 | def xxx 5 |]"
declb = "[xxx]"
seq = "[(`oeheo' | 238 | 11)]"
quote = "[`(333333)']"
define = "[(def a 2121212 | a)]"
defun = "[(defun (ff x) (* x 13) | (ff 14))]"
fun = "[(fun (x c) (+ x c))]"
apply1 = "[(+ 11 14)]"
apply2 = "[((fun (x c) (+ x c)) 11 14)]"
curry = "[(def aaa ((fun (a b) (* a b)) 3) | (aaa 11))]"
sym = "[(def tatao+ht-o*he<>i==== 555 | tatao+ht-o*he<>i====)]"
hash = "[{yayay:77777 rrr:111}]"
list = "[[11 33 449]]"
regex = "[/[^7]*777\\/88?/]"
date = "[3409-65-22]"
time = "[55:32:18]"
str = '["yaodui iw\"fhoeo"]'
num = "[444.22]"
test = "[| def yar (fun (x) (* 3 x)) |
  def peanut (fun (y z) (/ (- y z) z)) |
  (peanut (yar 66) 12) |]"
bad = "[(999)(888)]"
cond = "[(if (> xxx 13) then 12 else [3 3 5 3])]"

template = "ol[(* 3 8)] weee!  [(* \"okok\" 5)] okoko NO   no way okay but [\"how about now\"] yes?"    #"
template2 = "yayayay``nonono'ya'yayay"

env = Plasma::Interpreter::Env.new


statements = []
statements += [seq, quote, define, defun, fun, apply1, apply2, 
               sym, hash, list, regex, date, time, str, num, test, 
               decl, declb, defun, bad, curry, cond]

statements += [template, template2]



statements.each do |statement|
  parsed = plasma.parse(statement)
  evaluated = parsed.nil? ? "does not parse" : parsed.evaluate(env).to_plasma

  puts "#{statement} -> #{parsed.class} : #{evaluated}"
end
