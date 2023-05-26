# frozen_string_literal: true

require './test/test_helper'

class TestDiff < Minitest::Test
  include Diff
  #тестирование основной функции, которая всё объединяет
  #_________________________________________________________________________________________________
  def test_without_vari
    assert_equal '0', differebtiate_polynomial("20+3-5", "x")           #без переменных
    assert_equal '0', differebtiate_polynomial("4x+10x^2-134", "y")     #нет нужной переменной в списке
  end
  def test_one_vari
    assert_equal "1", differebtiate_polynomial("x", "x")                #просто переменная

    assert_equal '2', differebtiate_polynomial('2x^1+2', 'x')           #простые полиномы с одной переменной
    assert_equal '5x^4+6x+9', differebtiate_polynomial('x^5+3x^2+9', 'x')
  end
  def test_usual_polynom
    pol = '3x^2+2y^4+4x+3+y'

    assert_equal  "6x+4", differebtiate_polynomial(pol, "x")            #полином от двух переменных
    assert_equal  '8y^3+1', differebtiate_polynomial(pol, "y")
  end
  def test_with_minus
    pol = '-4y+2x^2+y^3-x^5'

    assert_equal '4x-5x^4', differebtiate_polynomial(pol, "x")          #понимает минус
    assert_equal '-4+3y^2', differebtiate_polynomial(pol, "y")
  end
  def test_high_degree
    assert_equal '15x^4+11x^10+707x^100',
                 differebtiate_polynomial('3x^5+x^11+7x^101', "x")          #степень может быть двузначной и выше
    assert_equal '15x^4+700x^99', differebtiate_polynomial('3x^5+y^10+7x^100', "x")
  end

  #__________________________________________________________________________________________________
  # тестирование класса переменной
  def test_vari_diff
    x = Variable.new('x', 4, 2)
    x.diff!
    assert_equal 8, x.coeff
    assert_equal 1, x.degree
    x.diff!
    assert_equal 8, x.coeff
    assert_equal 0, x.degree
  end

  def test_vari_tos
    x = Variable.new('x', 4, 2)
    assert_equal '4x^2', x.to_s
    x.diff!
    assert_equal '8x', x.to_s
    x.diff!
    assert_equal '8', x.to_s
    x = Variable.new('x', 3, 13)
    x.diff!
    assert_equal '29x^12', x.to_s
  end

  #_________________________________________________________________
  # тестирование функции строка->переменная

  #REVIEW: возможно тесты не будут проходить из-за id объектов
  def test_usual_vari
    assert_equal Variable.new('x', 4, 3), to_variable('4x^3')
    assert_equal Variable.new('y', 4, 1), to_variable('4y')
    assert_equal Variable.new('x', 1, 5), to_variable('x^5')
    assert_equal Variable.new('', 5, 0), to_variable('5')
  end

  #______________________________________________________________________
  # тестирование функции строка->список переменных
  #  не очень понимаю как тестировать список объектов
end
