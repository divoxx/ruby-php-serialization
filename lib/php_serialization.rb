$:.unshift(File.dirname(__FILE__))
require 'php_serialization/unserializer'

module PhpSerialization
  class << self
    def unserializer
      @unserializer ||= Unserializer.new
    end
    
    def load(str)
      unserializer.load(str)
    end
    
    alias :unserialize :load
    alias :restore :load
  end
end