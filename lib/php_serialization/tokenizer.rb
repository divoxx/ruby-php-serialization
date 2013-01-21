module PhpSerialization
  class Tokenizer
    def initialize(string)
      @string = string
    end

    def each
      while !@string.empty?
        token = case @string
        when /\A-?[0-9]+(\.[0-9]+)?/m then yield([:NUMBER, $&])
        when /\A"([^"]*)"/m         then yield([:STRING, $1])
        when /\A[^\s]/m             then yield([$&, $&])
        end
        
        @string = $'
      end
      
      yield([false, '$'])
    end
  end
end
