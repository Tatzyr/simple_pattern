#!/usr/bin/env ruby
# frozen_string_literal: true

class SimplePattern < Array
  VERSION = "0.1.0"

  def ===(other)
    zip(other).all? {|a, b| a === b }
  end

  class All < Array
    def ===(other)
      all? {|a| a === other }
    end
  end

  class Any < Array
    def self.===(other)
      true
    end

    def ===(other)
      any? {|a| a === other }
    end
  end

  class Not < Array
    def ===(other)
      !any? {|a| a === other }
    end
  end
end
