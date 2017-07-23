class Token
  attr_reader :type

  def initialize(type, value)
    @type, @value = type, value
  end

  def value
    @type == :int ? @value.to_f : @value
  end

  def priority
    return 1 if value == '+' || value == '-'
    return 2 if value == '*' || value == '/'
  end
end