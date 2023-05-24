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
  
end
