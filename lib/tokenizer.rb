require 'strscan'
require 'token'

class Tokenizer
  PATTERNS = {
      /\d+/ => :int,
      /[\/+\-*]/ => :op
  }

  def initialize
    @tokens = []
  end

  def parse(expression)
    @buffer = StringScanner.new(expression)
    until @buffer.eos?
      skip_space
      separate_tokens
    end
    @tokens
  end

  def separate_tokens
    PATTERNS.each do |regex, type|
      token = @buffer.scan(regex)
      @tokens << Token.new(type, token) if token
    end
  end

  def skip_space
    @buffer.skip(/\s+/)
  end

end