# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require 'DiffPolinom'
require 'is_polinom'

require "minitest/autorun"
require 'minitest/reporters'
Minitest::Reporters.use! unless ENV['RM_INFO']
