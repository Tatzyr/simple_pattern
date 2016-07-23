require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simple_pattern'

All = SimplePattern::All
Any = SimplePattern::Any
Not = SimplePattern::Not
