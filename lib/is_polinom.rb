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


