module PhpSerialization
  class Tokenizer
    def initialize(string)
      @string = string
    end

    def next_token
      token = nil

      token = case @string
      when /\A[0-9]+(\.[0-9]+)?/m then [:NUMBER, $&]
      when /\A"([^"]*)"/m         then [:STRING, $1]
      when /\A[^\s]/m             then [$&, $&]
      end
      @string = $'

      token unless token.nil?
    end
  end
end