class BinaryTreeNode
  attr_accessor :value
  attr_reader :left, :right

  def initialize(value)
    @value = value
    @left  = nil
    @right = nil
  end

  def insert_left(value)
    @left = BinaryTreeNode.new(value)
  end

  def insert_right(value)
    @right = BinaryTreeNode.new(value)
  end

  def between?(upper, lower)
    # puts "#{@value} between #{upper} and #{lower}"
    return true unless upper || lower
    return true if upper && lower && @value > lower && @value < upper
    return true if upper && lower.nil? && @value < upper
    return true if upper.nil? && lower && @value > lower

    false
  end

  def leaf?
    @left.nil? && @right.nil?
  end
end
