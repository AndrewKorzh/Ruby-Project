# frozen_string_literal: true
# A class for differentiating polynomials
class DiffPolinom
  # method for differentiating polynomials
  # @param polynomial [string] String with a polynomial to be differentiated
  # @param name [string] Name of the variable to be differentiated by
  # @return [String (frozen)] String with the result of differentiation of the input polynomial
  def self.diff_polinom(polynomial, name)
    string_list_1 = self.polin_to_string_list(polynomial, name)

    var_list = self.str_lst_to_var_string(string_list_1, name)

    var_list.each { |v| v.diff }

    return self.lst_var_to_string(var_list)
  end

  private
  # A class for monomials
  class Monomial
    attr_accessor :k, :n, :name

  # constructor for monomials class
  # @param name [string] Name of the variable to be differentiated by
  # @param k [int] Coefficient
  # @param n [int] Degree
  def initialize(name, k, n)
    @name = name
    @k = k
    @n = n
  end

  # @return [String (frozen)] String representation of a monomial
  def to_str
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

    # Differentiates a monomial
    def diff
      @k *= @n
      @n -= 1
    end
  end
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



  # concatenate list of monomials to a single string of polynomial
  # @return [String (frozen)] String of concatenated monomials
  # @param lst [Array] list of monomials
  def self.lst_var_to_string(lst)
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
  # Returns the monomial (object of class monomial) from the monomial (string)
  # @param s [string] String with a monomial
  # @param name [string] Name of the variable to be differentiated by
  # @return [DiffPolinom::Monomial] result monomial object
  def self.str_to_var(s, name)
    if s.include?('^')
      if s.include?('*')
        n = s[s.index('^')+1..-1].to_i
        k = s[0...s.index('*')].to_i

        return DiffPolinom::Monomial.new(name, k, n)
      else
        n = s[s.index('^')+1..-1].to_i

        if s.include?('-')
          return DiffPolinom::Monomial.new(name, -1, n)
        else
          return DiffPolinom::Monomial.new(name, 1, n)
        end
      end
    else
      if s.include?('*')
        k = s[0...s.index('*')].to_i

        return DiffPolinom::Monomial.new(name, k, 1)
      else
        return DiffPolinom::Monomial.new(name, 1, 1)
      end
    end
  end
  # Returns the list of monomials (object of class monomial) from the list of monomials (strings)
  # @param strings [Array] Array of strings
  # @param name [string] Name of the variable to be differentiated by
  # @return [Array] Array of monomial objects
  def self.str_lst_to_var_string(strings, name)
    var_str = []
    strings.each do |s|
      var_str << str_to_var(s, name)
    end
    return var_str
  end
  # Returns a list of monomials (strings) from a polynomial (string),
  # by removing the constants (the monomials that do not contain the
  # variable by which we differentiate)  def self.polin_to_string_list(s, name)
  # @param s [string] string with a polynomial to be differentiated
  # @param name [string] Name of the variable to be differentiated by
  # @return [Array] list of monomials (strings)
  def self.polin_to_string_list(s, name)
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
end

