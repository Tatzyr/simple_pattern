require 'simplecov'
SimpleCov.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simple_pattern'

All = SimplePattern::All
Any = SimplePattern::Any
Not = SimplePattern::Not
