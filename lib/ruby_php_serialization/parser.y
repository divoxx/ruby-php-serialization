class RubyPhpSerialization::Parser
rule

	serialization : object ';' { @object = val[0] }
								;
								
	object 			: null		 { result = val[0] }
				 			| bool		 { result = val[0] }
				 			| integer  { result = val[0] }
				 			| double   { result = val[0] }
				 			| array    { result = val[0] }
							| string   { result = val[0] }
				 			;          
	        		
	null 				: 'N' { result = nil }
			 				;
			    		
	bool 				: 'b' ':' NUMBER { result = Integer(val[2]) > 0 }
			 				;
			    		
	integer 		: 'i' ':' NUMBER { result = Integer(val[2]) }
							;
							
	double 			: 'd' ':' NUMBER { result = Float(val[2]) }
				 			;
				
	string 	 		: 's' ':' NUMBER ':' STRING { result = val[4] }
							;
				  		
	array   		: 'a' ':' NUMBER ':' '{' { @numeric_array = true } array_items '}' 
								{ 
									if @numeric_array
										result = []
										val[6].each { |(i,v)| result[i] = v }
									else
										result = Hash[*val[6].flatten]
									end
								}
							;
							
  array_items : array_items array_item { result = val[0] << val[1] }
							|												 { result = [] }
							;
					
	array_item 	: array_key ';' object			{ result = [val[0], val[2]] }
	 						| ';' array_key ';' object  { result = [val[1], val[3]] }
							;
							
	array_key   : integer	{ result = val[0] }
							|	string  { @numeric_array = false; result = val[0] }
							;
								
end

---- header ----
require 'ruby_php_serialization/tokenizer'

---- inner ----
  
	def parse(string)
		@tokenizer = Tokenizer.new(string)
		do_parse
		return @object
	ensure
		@tokenizer = nil
	end
  
  def next_token
    @tokenizer.next_token
  end