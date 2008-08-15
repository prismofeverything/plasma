require 'lib/plasma.rb'

plasma = Plasma::Interpreter::PlasmaGrammarParser.new

decl = "| 'eiii | 1233333 | (def xxx 5) |"
declb = "xxx"
seq = "('oeheo | 238 | 11)"
quote = "'(333333)"
define = "((def a 2121212) | a)"
defun = "(defun (ff x) (* x 13))"
fun = "(fun (x c) (+ x c))"
apply1 = "(+ 11 14)"
apply2 = "((fun (x c) (+ x c)) 11 14)"
curry = "((def aaa ((fun (a b) (* a b)) 3)) | (aaa 11))"
sym = "((def tatao+ht-o*he<>i==== 555) | tatao+ht-o*he<>i====)"
hash = "{yayay:77777 rrr:111}"
list = "[11 33 449]"
regex = "/[^7]*77788?/"
date = "3409-65-22"
time = "55:32:18"
str = '"yaodui iwfhoeo"'
num = "444.22"
test = "| (def yar (fun (x) (* 3 x))) |
  (def peanut (fun (y z) (/ (- y z) z))) |
  (peanut (yar 66) 12) |"
bad = "(999)(888)"

env = Plasma::Interpreter::Env.new


statements = [seq, quote, define, defun, fun, apply1, apply2, 
              sym, hash, list, regex, date, time, str, num, test, 
              decl, declb, defun, bad, curry]
statements.each do |statement|
  parsed = plasma.parse(statement)
  evaluated = parsed.nil? ? "does not parse" : parsed.evaluate(env).to_plasma

  puts "#{statement} -> #{parsed} : #{evaluated}"
end
