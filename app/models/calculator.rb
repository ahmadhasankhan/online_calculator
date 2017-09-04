require 'strscan'
require 'tokenizer'
require 'expression_parser'
require 'evaluator'

class Calculator
  DECIMAL_DIGITS = 2

  def evaluate(expression)
    begin
      validate(expression)

      #If the output is just one number then simply return
      if expression.scan(/\d+/).size == 1
        return expression
      end

      #Parse input string
      lexer = Tokenizer.new
      tokens = lexer.parse(expression)

      #Convert to postfix notation
      parser = ExpressionParser.new(tokens)
      postfix_exp = parser.run

      #Finally Evaluate The Expression
      result = format_result(Evaluator.new.run(postfix_exp.output))

      {:result => result, :message => nil}
    rescue => e
      {:result => nil, :message => e.message}
    end
  end

  private

  def validate(expression)
    result = /([0-9]*\.?[0-9]+[\/\+\-\*])+([-+]?[0-9]*\.?[0-9]+)/ =~ expression
    raise "Invalid Expression #{ expression }" if result != 0 || expression.include?('(') || expression.include?(')')
  end

  def format_result(result)
    # if the number is an integer, dont show the trailing zeros
    result.to_i == result ? result.to_i : result.round(DECIMAL_DIGITS)
  end
end