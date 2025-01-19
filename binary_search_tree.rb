require_relative './binary_tree'

class Bound
  attr_accessor :upper, :lower

  def initialize(upper = nil, lower = nil)
    @upper = upper
    @lower = lower
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

# def run_tests
  # desc = 'valid full tree'
  # tree = BinaryTreeNode.new(50)
  # left = tree.insert_left(30)
  # right = tree.insert_right(70)
  # left.insert_left(10)
  # left.insert_right(40)
  # right.insert_left(60)
  # right.insert_right(80)
  # result = binary_search_tree?(tree)
  # inorder_print(tree)
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
# end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

def find_second_largest(root)
  # To find the second largest, you find the right most leaf in the tree, or the right most node with no right. Then go back one.
  # If there is no right from the start, you have to go one left.
  # Modified depth first search, going only right.
  raise "Error" if root.nil? || root.leaf?

  node = root
  high_values = []
  while node
    high_values = high_values.push(node.value).max(2)
    return high_values.min if node.leaf?

    node = if node.right
             node.right
           elsif node.left
             node.left
           else
             nil
           end
  end
end

# Interview cake solution
# Simplifies problem first: How do I find the largest node?
# Then identifies the cases that dictate where the 2nd largest node would be:
#  1. The largest node has a left subtree 
#  2. The largest node does not have a left subtree
def find_largest(root_node)

  current = root_node
  while current
    return current.value unless current.right
    current = current.right
  end
end

def find_second_largest_ic(root_node)

  if !root_node || (!root_node.left && !root_node.right)
    raise 'Tree must have at least 2 nodes'
  end

  current = root_node

  while current
    # Case: current is largest and has a left subtree
    # 2nd largest is the largest in that subtree.
    if current.left && !current.right
      return find_largest(current.left)

    # Case: current is parent of largest, and largest has no children,
    # so current is 2nd largest.
    elsif current.right &&
          !current.right.left &&
          !current.right.right
      return current.value
    end

    current = current.right
  end
end

def run_tests
  desc = 'full tree'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  right = tree.insert_right(70)
  left.insert_left(10)
  left.insert_right(40)
  right.insert_left(60)
  right.insert_right(80)
  actual = find_second_largest(tree)
  expected = 70
  assert_equal(actual, expected, desc)

  desc = 'largest has a left child'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  right = tree.insert_right(70)
  left.insert_left(10)
  left.insert_right(40)
  right.insert_left(60)
  actual = find_second_largest(tree)
  expected = 60
  assert_equal(actual, expected, desc)

  desc = 'largest has a left subtree'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  right = tree.insert_right(70)
  left.insert_left(10)
  left.insert_right(40)
  right_left = right.insert_left(60)
  right_left_left = right_left.insert_left(55)
  right_left.insert_right(65)
  right_left_left.insert_right(58)
  actual = find_second_largest(tree)
  expected = 65
  assert_equal(actual, expected, desc)

  desc = 'second largest is root node'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  tree.insert_right(70)
  left.insert_left(10)
  left.insert_right(40)
  actual = find_second_largest(tree)
  expected = 50
  assert_equal(actual, expected, desc)

  desc = 'two nodes root is largest'
  tree = BinaryTreeNode.new(50)
  tree.insert_left(30)
  actual = find_second_largest(tree)
  expected = 30
  assert_equal(actual, expected, desc)

  desc = 'second largest in right offshoot left subtree'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  left.insert_right(40)
  left.insert_left(10)
  actual = find_second_largest(tree)
  expected = 40
  assert_equal(actual, expected, desc)

  desc = 'descending linked list'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(40)
  left_left = left.insert_left(30)
  left_left_left = left_left.insert_left(20)
  left_left_left.insert_left(10)
  actual = find_second_largest(tree)
  expected = 40
  assert_equal(actual, expected, desc)

  desc = 'ascending linked list'
  tree = BinaryTreeNode.new(50)
  right = tree.insert_right(60)
  right_right = right.insert_right(70)
  right_right.insert_right(80)
  actual = find_second_largest(tree)
  expected = 70
  assert_equal(actual, expected, desc)

  desc = 'error when tree has one node'
  tree = BinaryTreeNode.new(50)
  assert_raises(desc) { find_second_largest(tree) }

  desc = 'error when tree is empty'
  assert_raises(desc) { find_second_largest(nil) }
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

def assert_raises(desc)
  yield
  puts "#{desc} ... FAIL"
rescue
  puts "#{desc} ... PASS"
end

run_tests
