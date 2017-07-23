class ExpressionParser
  attr_reader :output

  def initialize(tokens)
    @tokens = tokens
    @output = []
    @operators = []
  end

  def run
    @tokens.each do |token|
      push_number(token) if token.type == :int
      process_operator(token) if token.type == :op
    end

    @output += @operators.reverse

    self
  end

  def push_number(token)
    @output << token
  end

  def process_operator(token)
    while operator_priority_is_less_than_or_equal_than(token)
      @output << @operators.pop
    end

    @operators << token
  end

  def operator_priority_is_less_than_or_equal_than(token)
    @operators.last && (token.priority <= @operators.last.priority)
  end
end