def is_number?(s)
  s =~ /[0-9]/
end

def is_letter?(s)
  s =~ /[A-Za-z]/
end

def is_polinom?(p)
  i = 0
  s = '*^+-'
  ss = '+-'
  while i < p.length - 1
    if (s.include? p[i]) && (s.include? p[i+1])
      return "error"
    end
    if is_number?(p[i]) && is_letter?(p[i+1])
      return "error"
    end
    if is_letter?(p[i]) && p[i+1]!='^' && (ss.include? p[i+1] == false)
      return "error"
    end
    i += 1
  end
  i = 0
  while i < p.length - 2
    if is_letter?(p[i]) && p[i+1] == '*' && is_letter?(p[i+2])
      return "error"
    end
    i += 1
  end
  i = 0
  while i < p.length
    if p[i] == '^'
      while s.include? p[i+1] == false && i < p.length
        if is_letter?(p[i+1])
          return "error"
        end
        i += 1
      end
    end
    i += 1
  end
  return DiffPolinom(p)
end