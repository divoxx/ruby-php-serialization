class PhpSerialization::Unserializer
rule

  serialization   : data ';' { @object = val[0] }
                  ;
                
  data            : null     { result = val[0] }
                  | bool     { result = val[0] }
                  | integer  { result = val[0] }
                  | double   { result = val[0] }
                  | array    { result = val[0] }
                  | string   { result = val[0] }
                  | object   { result = val[0] }
                  ;          
                  
  null            : 'N' { result = nil }
                  ;
                  
  bool            : 'b' ':' NUMBER { result = Integer(val[2]) > 0 }
                  ;
                  
  integer         : 'i' ':' NUMBER { result = Integer(val[2]) }
                  ;
                  
  double          : 'd' ':' NUMBER { result = Float(val[2]) }
                  ;
                  
  string          : 's' ':' NUMBER ':' STRING { result = val[4] }
                  ;
                  
  object          : 'O' ':' NUMBER ':' STRING ':' NUMBER ':' '{' attribute_list '}' 
                    { 
                      if Object.const_defined?(val[4])
                        result = Object.const_get(val[4]).new
                        
                        val[9].each do |(attr_name, value)|
                          result.instance_variable_set("@#{attr_name}", value)
                        end
                      else
                        result = Struct.new(val[4], *val[9].map { |(k,v)| k.to_sym }).new(*val[9].map { |(k,v)| v })
                      end
                    }
                  ;

  attribute_list  : attribute_list attribute { result = val[0] << val[1] }
                  |                           { result = [] }
                  ;

  attribute       : data ';' data  ';'  { @numeric_array = false unless val[0].is_a?(Integer); result = [val[0], val[2]] }
                  ;
                                    
  array           : 'a' ':' NUMBER ':' '{' { @numeric_array = true } attribute_list '}' 
                    { 
                      if @numeric_array
                        result = []
                        val[6].each { |(i,v)| result[i] = v }
                      else
                        result = Hash[*val[6].flatten]
                      end
                    }
                  ;
                                                    
end

---- header ----
require 'php_serialization/tokenizer'

---- inner ----  
  def initialize(tokenizer_klass = Tokenizer)
    @tokenizer_klass = tokenizer_klass
  end
  
  def run(string)
    @tokenizer = @tokenizer_klass.new(string)
    yyparse(@tokenizer, :each)
    return @object
  ensure
    @tokenizer = nil
  end
  
  def next_token
    @tokenizer.next_token
  end