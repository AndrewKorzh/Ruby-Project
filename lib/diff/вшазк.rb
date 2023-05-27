def is_number?(s)
  s =~ /[0-9]/
end

def is_letter?(s)
  s =~ /[A-Za-z]/
end

class InvalidOperation < RuntimeError; end
def diff(expr, var)
  coefs = []
  variables = []
  signs = []
  pows = []
  s = '*^+-'
  i = 0
  ss = ""
  while i < expr.length
    ss = ""
    if is_number?(expr[i])
      if expr[i - 1] != '^'
        coefs += [expr[i]]
      else
        while is_number?(expr[i])
          ss += expr[i]
          i += 1
        end
        pows += [ss]
        signs += [expr[i]]
      end
    elsif is_letter?(expr[i])
      variables += [expr[i]]
    elsif s.include? expr[i]
      signs += [expr[i]]
    else
      raise InvalidOperation
    end
    if is_letter?(expr[i]) && expr[i + 1] != '^'
      pows += ['1']
    end
    if variables.length > coefs.length
      coefs += ['1']
    end
    if is_number?(expr[i]) && expr[i + 1] != '*' && expr[i - 1] != '^'
      variables += ['1']
    end
    i += 1
  end
  s = ''
  i = 0
  signs.delete('^')
  signs.delete('*')
  if variables[variables.length - 1] == '1'
    signs.pop(1)
  end
  if variables.include?(var) == false
    return '0'
  else
    while i < variables.length
      if variables[i] == var
        s += (coefs[i].to_i * pows[i].to_i).to_s
        if variables[i + 1] != '1'
          s += '*'
          s += variables[i]
        end
        if pows[i].to_i > 2
          s += '^'
          s += (pows[i].to_i - 1).to_s
        end
        if signs[i] != nil && variables.drop(1).include?(var)
          s += signs[i]
        end
      end
      i += 1
    end
  end
  return s
end


#expr = "5*x^2+7*x^10-5*x^23"
#expr = "x"
#expr = "x^2"
expr = "-2*x+3"
x = "x"

puts diff(expr, x)
