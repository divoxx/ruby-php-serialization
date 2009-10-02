$:.unshift(File.dirname(__FILE__))
require 'php_serialization/parser'

module PhpSerialization
  class << self
    def unserialize(str)
      Parser.new.parse(str)
    end
    
    alias :load :unserialize
    alias :restore :unserialize
  end
end