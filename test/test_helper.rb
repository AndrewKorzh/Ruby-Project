# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "diff"
require 'DiffPolinom'

require "minitest/autorun"
require 'minitest/rm_reporter_plugin'
Minitest::Reporters.use! unless ENV['RM_INFO']
