require 'token'
class Evaluator
  def run(tokens)
    @numbers = []

    tokens.each do |token|
      push_number(token) if token.type == :int
      evaluate_operation(token) if token.type == :op
    end

    @numbers.last.value
  end

  private

  def push_number(token)
    @numbers << token
  end

  def evaluate_operation(token)
    right_number = @numbers.pop
    left_number = @numbers.pop

    raise 'invalid postfix expression' unless right_number && left_number

    result = evaluate(left_number.value, right_number.value, token)

    @numbers << Token.new(:int, result)
  end

  def evaluate(left_number, right_number, operation)
    case operation.value
      when '+' then
        left_number + right_number
      when '-' then
        left_number - right_number
      when '*' then
        left_number * right_number
      when '/' then
        left_number / right_number
    end
  end
end