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
    puts "#{@value} between #{upper} and #{lower}"
    # We are the root node and have not set any bounds
    return true unless upper || lower

    # We have traversed both left and right and thus have upper and lower bounds
    return true if upper && lower && @value > lower && @value < upper

    # We have only traversed left, and only have an upper bound
    return true if upper && lower.nil? && @value < upper

    # We have only traversed right, and only have a lower bound
    return true if upper.nil? && lower && @value > lower

    false
  end

  def leaf?
    @left.nil? && @right.nil?
  end
end
