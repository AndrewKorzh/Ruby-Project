require 'DiffPolinom'
polinlist = ["x^2-5*x+7-3*x^8", "x^5-5*x^8+7-3*x^8", "-x^2-5*x+7-3*x^8", "7*x^8-5*x", "-5+x^8"]
polinlist.each do |p|
  puts "Polinom: #{p}"
  puts "DiffPolin: #{DiffPolinom.diff_polinom(p, 'x')}"
end