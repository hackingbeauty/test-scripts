require 'test/unit'
require File.join(File.dirname(__FILE__), '..', 'calculator')

class CalculatorTest < Test::Unit::TestCase
  def test_that_calculator_adds
    calculator  = Calculator.new
    result      = calculator.add(2,2)
    expected    = 4
    assert_equal expected, result
  end
  def test_that_calculator_divides
    calculator  = Calculator.new
    result1     = calculator.divide(10,5)
    expected1   = 2.0
    assert_equal  expected1, result1
    result2     = calculator.divide(5,10)
    expected2   = 0.5
    assert_equal expected2, result2
  end
end