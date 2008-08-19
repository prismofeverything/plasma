def fac(n)
  return 1 if n <= 1
  n * fac(n-1)
end

puts fac(50)
