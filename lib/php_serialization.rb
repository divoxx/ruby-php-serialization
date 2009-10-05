$:.unshift(File.dirname(__FILE__))
require 'php_serialization/serializer'
require 'php_serialization/unserializer'

module PhpSerialization
  class << self
    def serializer
      @serializer ||= Serializer.new
    end
    
    def unserializer
      @unserializer ||= Unserializer.new
    end
    
    def load(str)
      unserializer.run(str)
    end
    
    def dump(object)
      serializer.run(object)
    end
    
    alias :unserialize :load
    alias :restore :load
    alias :serialize :dump
  end
end

module PhpSessionSerialization
  class << self
    def load(str)
      hash = {}
      
      while str =~ /^([^|]+)\|(.*?[;}])(?=[^;}|]+\||$)/
        hash[$1] = PhpSerialization.load($2)
        str = $'
      end
      
      hash
    end
    
    def dump(hash)
      str = ""
      hash.each { |key,value| str << "#{key}|#{PhpSerialization.dump(value)}" }
      str
    end
  end
end