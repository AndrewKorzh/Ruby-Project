def is_number?(s)
  s =~ /[0-9]/
end

def is_letter?(s)
  s =~ /[A-Za-z]/
end

def is_polinom?(p)
  s = '*^+-'
  ss = '+-'
  (p.length - 1).times do |i|
    if (s.include? p[i]) && (s.include? p[i+1])
      return false
    end
    if is_number?(p[i]) && is_letter?(p[i+1])
      return false
    end

  end
  (p.length - 2).times do |i|
    if is_letter?(p[i]) && p[i+1] == '*' && is_letter?(p[i+2])
      return false
    end
  end
  i = 0
  while i < p.length
    if p[i] == '^'
      j = i + 1
      while j < p.length && s.include?(p[j]) == false
        if is_letter?(p[j])
          return false
        end
        j += 1
      end
    end
    i += 1
  end
  return true
end


#
s2 = []
s2.push("x^2+5*x-4")
s2.push("x^2+5*x+5")
s2.push("x-2")
s2.push("4*x+10*x^2-134")
s2.push("x+3-y")
s2.push("2x")
s2.push("9xi")
s2.push("x^q-5")
s2.push("-")

s2.push("x^2+")
s2.push("x^2+5**x+5")
s2.push("x-2^2")
s2.push("4*x+10*x^2-13[4]")
s2.push("x+3-y-")
s2.push("2x2")
s2.push("aboba")
s2.push("x^q-5")
s2.push("")

s2.push("x^222222+22222*x^55555")
s2.push("x^2+5*x+5+y^222-z-x")
s2.push("x-2+x+x+x+x-x-x")
s2.push("4*x+10*x^2-13")
s2.push("x+3-y-xyz")
s2.push("2*x+2*ccccc")
s2.push("aboba")
s2.push("x^q-5")
s2.push("")

(s2.length).times do |i|
  p s2[i]
  p is_polinom?(s2[i])
end