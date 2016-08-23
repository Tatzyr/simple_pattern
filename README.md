# SimplePattern

[![Gem Version](https://badge.fury.io/rb/simple_pattern.svg)](http://badge.fury.io/rb/simple_pattern)
[![Build Status](https://travis-ci.org/Tatzyr/simple_pattern.svg?branch=master)](https://travis-ci.org/Tatzyr/simple_pattern)
[![Code Climate](https://codeclimate.com/github/Tatzyr/simple_pattern/badges/gpa.svg)](https://codeclimate.com/github/Tatzyr/simple_pattern)
[![Test Coverage](https://codeclimate.com/github/Tatzyr/simple_pattern/badges/coverage.svg)](https://codeclimate.com/github/Tatzyr/simple_pattern/coverage)
[![Dependency Status](https://gemnasium.com/Tatzyr/simple_pattern.svg)](https://gemnasium.com/Tatzyr/simple_pattern)

Very simple and plain pattern matching library using `Object#===`

## Synopsis

```ruby
require "simple_pattern"

All = SimplePattern::All
Any = SimplePattern::Any
Not = SimplePattern::Not

words = [
  [100,           :english], # Non valid word
  ["PASSPORT",    :english], # All caps word
  ["the",         :english], # English stopword
  ["little",      :english], # English word
  ["Schrödinger", :german],  # German word
  ["rendezvous",  :french],  # French word
]

words.each do |word|
  case word
  when SimplePattern[Not[String], Any]
    puts "Non valid word"
  when SimplePattern[/\A[A-Z]+\z/, Any]
    puts "All caps word"
  when SimplePattern[Any["a", "an", "the"], :english]
    puts "English stopword"  
  when SimplePattern[Any, :english]
    puts "English word"
  when SimplePattern[Any, Not[:french]]
    puts "German word"
  else
    puts "French word"
  end
end
```

More examples are at [`spec/simple_pattern_spec.rb`](https://github.com/Tatzyr/simple_pattern/blob/master/spec/simple_pattern_spec.rb).

## Installation

```
$ gem install simple_pattern
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Tatzyr/simple_pattern.

