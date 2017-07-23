require 'strscan'
require 'tokenizer'
require 'expression_parser'
require 'evaluator'

class Calculator
  def evaluate(expression)
    validate(expression)

    #If the output is just one number then simply returning
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
    Evaluator.new.run(postfix_exp.output)
  end

  private

  def validate(expression)
    result = /([0-9]*\.?[0-9]+[\/\+\-\*])+([-+]?[0-9]*\.?[0-9]+)/ =~ expression
    raise "Invalid Expression #{ expression }" if result != 0 || expression.include?('(') || expression.include?(')')
  end
end