$:.unshift(File.dirname(__FILE__))
require 'ruby_php_serialization/parser'

module RubyPhpSerialization
  extend self
  
  def php_unserialize(str)
    Parser.new.parse(str)
  end
end