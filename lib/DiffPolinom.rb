# frozen_string_literal: true

class Monomial
  attr_accessor :k, :n, :name

  def initialize(name, k, n)
    @name = name
    @k = k
    @n = n
  end

  def to_str()
    if @n == 1
      if @k == 1
        return "#{@name}"
      else
        return "#{@k}*#{@name}"
      end
    else
      if @n == 0
        return "#{@k}"
      else
        if @k == 1
          return "#{@name}^#{@n}"
        else
          return "#{@k}*#{@name}^#{@n}"
        end
      end
    end
  end

  def diff()
    @k *= @n
    @n -= 1
  end
end

def lst_var_to_string(lst)
  if lst.empty?
    return "0"
  end

  s = lst[0].to_str()

  for i in 1..lst.length-1 do
    if lst[i].k > 0
      s += "+#{lst[i].to_str()}"
    else
      s += lst[i].to_str()
    end
  end

  return s
end
#Возвращает одночлен(объект класса monomial) из одночлена(строки)
def str_to_var(s, name)
  if s.include?('^')
    if s.include?('*')
      n = s[s.index('^')+1..-1].to_i
      k = s[0...s.index('*')].to_i

      return Monomial.new(name, k, n)
    else
      n = s[s.index('^')+1..-1].to_i

      if s.include?('-')
        return Monomial.new(name, -1, n)
      else
        return Monomial.new(name, 1, n)
      end
    end
  else
    if s.include?('*')
      k = s[0...s.index('*')].to_i

      return Monomial.new(name, k, 1)
    else
      return Monomial.new(name, 1, 1)
    end
  end
end
#Возвращает список одночленов(объект класса monomial) из списка одночленов(cтрок)
def str_lst_to_var_string(strings, name)
  var_str = []
  strings.each do |s|
    var_str << str_to_var(s, name)
  end
  return var_str
end
#Возвращает сптсок одночленов(строк) из многочлена(строки),
#убирая константы(одночлены не содержащие переменой по которой диффиренцируем)
def polin_to_string_list(s, name)
  lst = []

  for i in (s.length-1).downto(0) do
    if s[i] == '+' || s[i] == '-'
      if s[i] == '-'
        if s[i..-1].include?(name)
          lst.insert(0, s[i..-1])
        end
      else
        if s[i..-1].include?(name)
          lst.insert(0, s[i+1..-1])
        end
      end

      s = s[0...i]
    end
  end

  if s.length != 0 && s.include?(name)
    lst.insert(0, s)
  end

  return lst
end

# Финальная функция объединяющая все предыдущие
def diff_polinom(s, name)
  string_list_1 = polin_to_string_list(s, name)
  var_list = str_lst_to_var_string(string_list_1, name)

  var_list.each { |v| v.diff() }

  return lst_var_to_string(var_list)
end


polinlist = ["x^2-5*x+7-3*x^8", "x^5-5*x^8+7-3*x^8", "-x^2-5*x+7-3*x^8", "7*x^8-5*x", "-5+x^8"]
polinlist.each do |p|
  puts "Polinom: #{p}"
  puts "DiffPolin: #{diff_polinom(p, 'x')}"
end