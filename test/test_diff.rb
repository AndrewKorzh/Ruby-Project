# frozen_string_literal: true

require "test_helper"

class TestDiff < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Diff::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_without_vari
    assert_equal '0', differebtiate_polynomial("20+3-5", "x")
    assert_equal '0', differebtiate_polynomial("4+10-134", "y")
  end

  def test_one_vari
    assert_equal "1", differebtiate_polynomial("x", "x")
    assert_equal "1", differebtiate_polynomial("y", "y")

    assert_equal "0", differebtiate_polynomial("y", "x")
    assert_equal "0", differebtiate_polynomial("3y^1+10+5", "x")

    assert_equal '2', differebtiate_polynomial('2x^1+2', 'x')
    assert_equal '5x^4+6x+9', differebtiate_polynomial('x^5+3x^2+9', 'x')
  end

  def test_usual_polynom
    pol = '3x^2+2y^4+4x+3+y'

    assert_equal  "6x+4", differebtiate_polynomial(pol, "x")
    assert_equal  '8y^3+1', differebtiate_polynomial(pol, "y")
  end
end
