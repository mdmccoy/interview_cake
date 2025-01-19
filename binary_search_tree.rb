require_relative './binary_tree'

class Bound
  attr_accessor :upper, :lower

  def initialize(upper = nil, lower = nil)
    @upper = upper
    @lower = lower
  end
end

class BinaryTreeNode
  def between?(upper, lower)
    # puts "#{@value} between #{upper} and #{lower}"
    return true unless upper || lower
    return true if upper && lower && @value > lower && @value < upper
    return true if upper && lower.nil? && @value < upper
    return true if upper.nil? && lower && @value > lower

    false
  end
end

def print(value, upper, lower)
  puts "#{value} - upper: #{upper}, lower: #{lower}"
end

def inorder_print(node)
  if node
    inorder_print(node.left)
    puts node.value.inspect
    inorder_print(node.right)
  end
end

def binary_search_tree?(root)
  # Determine if the tree is a valid binary search tree.
  # Use DFS, keeping an upper/lower bound that each node must fit in as you traverse the tree.
  # DFS uses a stack. Stacl is FILO.
  # If you traverse right, you set a lower bound of the current nodes value.
  # If you traverse left, you set an upper bound of the current nodes valuel.
  
  nodes = []
  nodes << [root.left, Bound.new(root.value, nil)] if root.left
  nodes << [root.right, Bound.new(nil, root.value)] if root.right

  until nodes.empty?
    node, bounds = nodes.pop

    # print(node.value,bounds.upper, bounds.lower)

    result = node.between?(bounds.upper, bounds.lower)

    # p result

    return false unless result

    # Add children to the top of the stack
    nodes << [node.left, Bound.new(node.value, bounds.lower)] if node.left
    nodes << [node.right, Bound.new(bounds.upper, node.value)] if node.right
  end

  true
end

def run_tests
  desc = 'valid full tree'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  right = tree.insert_right(70)
  left.insert_left(10)
  left.insert_right(40)
  right.insert_left(60)
  right.insert_right(80)
  result = binary_search_tree?(tree)
  inorder_print(tree)
  # assert_true(result, desc)

  # desc = 'both subtrees valid but tree invalid'
  # tree = BinaryTreeNode.new(50)
  # left = tree.insert_left(30)
  # right = tree.insert_right(80)
  # left.insert_left(20)
  # left.insert_right(60)
  # right.insert_left(70)
  # right.insert_right(90)
  # result = binary_search_tree?(tree)
  # assert_false(result, desc)

  # desc = 'descending linked list'
  # tree = BinaryTreeNode.new(50)
  # left = tree.insert_left(40)
  # left_left = left.insert_left(30)
  # left_left_left = left_left.insert_left(20)
  # left_left_left.insert_left(10)
  # result = binary_search_tree?(tree)
  # assert_true(result, desc)

  # desc = 'out of order linked list'
  # tree = BinaryTreeNode.new(50)
  # right = tree.insert_right(70)
  # right_right = right.insert_right(60)
  # right_right.insert_right(80)
  # result = binary_search_tree?(tree)
  # assert_false(result, desc)

  # desc = 'one node tree'
  # tree = BinaryTreeNode.new(50)
  # result = binary_search_tree?(tree)
  # assert_true(result, desc)
end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

run_tests
