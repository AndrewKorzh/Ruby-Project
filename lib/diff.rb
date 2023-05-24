# frozen_string_literal: true

require_relative "diff/version"

module Diff
  class Error < StandardError; end

  def self.hello
    "hello world"
  end

  def self.sum(a,b)
    return a+b
  end

  class Polynomial
    def initialize(expression)
      @expression = expression
    end

    def differentiate(variable)
      terms = @expression.split(/(?=[+-])/)
      result_terms = []

      terms.each do |term|
        if term.include?(variable)
          coefficient, power = term.scan(/([-+]?\d*)\*?#{variable}\^?(\d*)/).flatten
          coefficient = coefficient.empty? ? "1" : coefficient
          power = power.empty? ? "1" : power
          derivative_coefficient = (coefficient.to_i * power.to_i).to_s
          derivative_power = (power.to_i - 1).to_s
          result_terms << "#{derivative_coefficient}*#{variable}^#{derivative_power}"
        end
      end

      result_terms.join("+")
    end
  end

  polynomial = Polynomial.new("x^2+4*x+3-y")
  puts polynomial.differentiate("x") # Output: 2*x+4


    end
