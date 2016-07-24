# frozen_string_literal: true

require "simple_pattern/version"

class SimplePattern < Array
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
