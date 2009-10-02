$:.unshift(File.dirname(__FILE__))
require 'php_serialization/parser'

module PhpSerialization
  def self.unserialize(str)
    Parser.new.parse(str)
  end
end