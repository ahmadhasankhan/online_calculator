module CalculatorsHelper
  def format_result(result)
    number_with_precision(result, precision: 2)
  end
end
