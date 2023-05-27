# frozen_string_literal: true

require './test/test_helper'

class TestDiff < Minitest::Test

  def test_without_vari
    assert_equal '0', DiffPolinom.diff_polinom("20+3-5", "x")
    assert_equal '0', DiffPolinom.diff_polinom("4*x+10*x^2-134", "y")
  end

  def test_one_vari
    assert_equal "1", DiffPolinom.diff_polinom("x", "x")

    assert_equal '2', DiffPolinom.diff_polinom('2*x^1+2', 'x')
    assert_equal '5*x^4+6*x', DiffPolinom.diff_polinom('x^5+3*x^2+9', 'x')
  end

  def test_usual_polynom
    pol = '3*x^2+2*y^4+4*x+3+y'

    assert_equal  "6*x+4", DiffPolinom.diff_polinom(pol, "x")
    assert_equal  "8*y^3+1", DiffPolinom.diff_polinom(pol, "y")
  end

  def test_with_minus
    pol = "-4*y+2*x^2+y^3-x^5"

    assert_equal '4*x-5*x^4', DiffPolinom.diff_polinom(pol, "x")
    assert_equal '-4+3*y^2', DiffPolinom.diff_polinom(pol, "y")
  end
  def test_high_degree
    assert_equal '15*x^4+11*x^10+707*x^100',
                 DiffPolinom.diff_polinom('3*x^5+x^11+7*x^101', "x")
    assert_equal '15*x^4+700*x^99', DiffPolinom.diff_polinom('3*x^5+y^10+7*x^100', "x")
  end

  def test_monomial_diff
    x = DiffPolinom::Monomial.new('x', 4, 2)
    x.diff
    assert_equal 8, x.k
    assert_equal 1, x.n
    x.diff
    assert_equal 8, x.k
    assert_equal 0, x.n
  end

  def test_monomial_tostr
    x = DiffPolinom::Monomial.new('x', 4, 2)
    assert_equal '4*x^2', x.to_str
    x.diff
    assert_equal '8*x', x.to_str
    x.diff
    assert_equal '8', x.to_str
    x = DiffPolinom::Monomial.new('x', -3, 13)
    x.diff
    assert_equal '-39*x^12', x.to_str
    x = DiffPolinom::Monomial.new('x', -1, 1)
    x.diff
    assert_equal "-1", x.to_str
  end

  def test_usual_vari
    x = DiffPolinom.str_to_var("4*x^3", "x")
    assert_equal ['x', 4, 3], [x.name, x.k, x.n]
    y = DiffPolinom.str_to_var('-4*y', "y")
    assert_equal ['y', -4, 1], [y.name, y.k, y.n]
    x = DiffPolinom.str_to_var('x^5', "x")
    assert_equal ['x', 1, 5], [x.name, x.k, x.n]
    y = DiffPolinom.str_to_var('5', "y")
    assert_equal ["y", 1, 1], [y.name, y.k, y.n]
  end

  def test_polin_to_string_list
    pol = "-4*y+2*x^2+y^3-x^5+10"
    assert_equal %w[2*x^2 -x^5], DiffPolinom.polin_to_string_list(pol, "x")
    assert_equal %w[-4*y y^3], DiffPolinom.polin_to_string_list(pol, "y")
  end

  def test_lst_var_to_string
    x1 = DiffPolinom::Monomial.new("x", -2, 5)
    x2 = DiffPolinom::Monomial.new("x", 1, 1)
    x3 = DiffPolinom::Monomial.new("x", 6, 0)
    vars = [x1, x2, x3]
    assert_equal "-2*x^5+x+6", DiffPolinom.lst_var_to_string(vars)
    vars = []
    assert_equal "0", DiffPolinom.lst_var_to_string(vars)
  end
end
