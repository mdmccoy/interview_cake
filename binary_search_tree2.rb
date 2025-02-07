require_relative './binary_tree.rb'

def binary_search_tree?(root)

  # Determine if the tree is a valid binary search tree.
  # In a binary search tree, the nodes to the left are less than the current node, the nodes to the right are more than the current node
  # 

  # You want to do DFS, checking that each subsequent node is less an upper bound and a lower bound
  # As you traverse left change your upper bound, everything MUST be lower than that
  # As you traverse right change your lower bound, everything MUST be higher than that

  nodes = [{
    node: root,
    upper_bound: nil,
    lower_bound: nil
  }]

  while nodes.size.positive?
    node_bound_hash = nodes.pop
    node = node_bound_hash[:node]
    upper_bound = node_bound_hash[:upper_bound]
    lower_bound = node_bound_hash[:lower_bound]

    # Is the node between the upper and lower bounds?
    return false unless node.between?(upper_bound, lower_bound)

    nodes << { node: node.left, upper_bound: node.value, lower_bound: lower_bound } if node.left
    nodes << { node: node.right, upper_bound: upper_bound, lower_bound: node.value } if node.right
  end
  
  true
end

# Tests

def run_tests_valid_tree
  desc = 'valid full tree'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  right = tree.insert_right(70)
  left.insert_left(10)
  left.insert_right(40)
  right.insert_left(60)
  right.insert_right(80)
  result = binary_search_tree?(tree)
  assert_true(result, desc)

  desc = 'both subtrees valid'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(30)
  right = tree.insert_right(80)
  left.insert_left(20)
  left.insert_right(60)
  right.insert_left(70)
  right.insert_right(90)
  result = binary_search_tree?(tree)
  assert_false(result, desc)

  desc = 'descending linked list'
  tree = BinaryTreeNode.new(50)
  left = tree.insert_left(40)
  left_left = left.insert_left(30)
  left_left_left = left_left.insert_left(20)
  left_left_left.insert_left(10)
  result = binary_search_tree?(tree)
  assert_true(result, desc)

  desc = 'out of order linked list'
  tree = BinaryTreeNode.new(50)
  right = tree.insert_right(70)
  right_right = right.insert_right(60)
  right_right.insert_right(80)
  result = binary_search_tree?(tree)
  assert_false(result, desc)

  desc = 'one node tree'
  tree = BinaryTreeNode.new(50)
  result = binary_search_tree?(tree)
  assert_true(result, desc)
end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

# run_tests_valid_tree

def find_second_largest(root_node)
  raise "Error" if root_node.nil? || root_node.leaf?

  # Find the second largest item in the binary search tree.
  # A brute force approach to this would be to traverse the whole tree, keeping track of the two largest values
  # along the way. When we've traversed the whole tree, then we just look at the 2nd of the two values
  # nodes = [root_node]
  # two_highest = []
  
  # until nodes.empty?
  #   node = nodes.pop
  #   two_highest = (two_highest + [node.value]).max(2)

  #   nodes << node.left if node.left
  #   nodes << node.right if node.right
  # end

  
  # two_highest.min
  
  # nodes = [root_node]
  # two_highest = []

  # until nodes.compact.empty?
  #   node = nodes.pop
  #   two_highest = (two_highest + [node.value]).max(2)
    

  #   # We only want to go left if we have to. If the tree has a right sub branch
  #   # than the answer is there.
    
  #   nodes << if node.right
  #     node.right
  #   elsif node.left
  #     node.left
  #   else
  #     nil
  #   end
  # end

  # two_highest.min
  
  while root_node
    if root_node.left && !root_node.right
      return find_largest_node(root_node.left)
    elsif root_node.right && root_node.right.leaf?
      return root_node.value
    end

    root_node = root_node.right
  end
end

def find_largest_node(tree)  
  while tree
    return tree.value unless tree.right
    tree = tree.right
  end
end

# Tests


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
