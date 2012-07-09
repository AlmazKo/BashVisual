$:.unshift(File.dirname(__FILE__) + '/..')

require "simplecov"
require "test/unit"
require "bash-visual"

SimpleCov.coverage_dir('.coverage')
SimpleCov.start
