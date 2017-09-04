require 'rails_helper'

RSpec.describe Calculator, type: :model do
  describe 'evaluate' do
    let(:calc) {Calculator.new}
    let(:valid_expressions) {{'222+3' => 225, '5*3+1+6/2+9*100' => 919, '5*3+1+6/85+9*100' => 916.07}}
    let(:invalid_expressions) {[' ', '222', '(5*3)+1+6/2+9*100', '5*3+1+6/2+(9*100)', '5*3+1+6/2+']}

    it 'evaluates the valid expressions and returns the correct results' do
      valid_expressions.each do |expression, expected_result|
        output = calc.evaluate(expression)
        expect(output[:result]).to eq(expected_result)
        expect(output[:message]).to be_nil
      end
    end

    it 'evaluates the invalid expressions and returns the error message' do
      invalid_expressions.each do |expression, result|
        output = calc.evaluate(expression)
        expect(output[:result]).to be_nil
        expect(output[:message]) =~ /"Invalid Expression #{result}"/
      end
    end
  end
end
