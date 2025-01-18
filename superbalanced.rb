# Write a method to see if a binary tree ↴ is "superbalanced" (a new tree property we just made up).

# A tree is "superbalanced" if the difference between the depths of any two leaf nodes ↴

# A leaf node is a tree node with no children.

# It's the "end" of a path to the bottom, from the root.
# is no greater than one. 
 

# Subproblem 1 - Find all leaf nodes
# 

# BFS - As we traverse down down the tree, keep a list of all discovered leaf nodes. You dont know its a leaf node until you get to the next level
# You dont know you need to track it until you've gone past it, so maybe not a good match for this problem
# 
# DFS - Traverse down each branch until you hit the end. The end is a leaf node. Keep track of all leaf nodes and their depths (level).
# As you find a leaf node, check to see if it is within 1 depth of all other leaf nodes. If it is not, return false. If it is, continue
# searching for the next leaf node.
# 
# Problem 1 - Write a DFS algo in Ruby
# Problem 2 - Use that algo to traverse a tree and find all leaf nodes
require 'set'
require 'byebug'
LEAF_NODE_DEPTHS = Set.new


def balanced?(tree_root)
  LEAF_NODE_DEPTHS.clear

  # Determine if the tree is superbalanced.
  
  tree_complete = false
  node = tree_root
  next_node = nil
  depth = 0


  until tree_complete
    node = next_node if next_node

    if !node.left? && !node.right?
      LEAF_NODE_DEPTHS << depth
      depth -= 1
      next_node = node.parent
    elsif (node.gone_left && node.gone_right) || (!node.left? && node.gone_right) || (!node.right? && node.gone_left)
      depth -= 1
      next_node = node.parent
    elsif node.left? && !node.gone_left
      depth += 1
      node.gone_left = true
      next_node = node.left
    elsif node.right? && !node.gone_right
      depth += 1
      node.gone_right = true
      next_node = node.right
    end

    if LEAF_NODE_DEPTHS.size > 2 && (LEAF_NODE_DEPTHS.max - LEAF_NODE_DEPTHS.min > 1)
      tree_complete = true
    end
    tree_complete = true if next_node.nil?
  end

  return false if LEAF_NODE_DEPTHS.max - LEAF_NODE_DEPTHS.min > 1

  true
end

# First solution because "DFS is easily implemented with recursion"
def dfs_recursive(node, depth = 0)
  return unless node

  if !node.left? && !node.right?
    LEAF_NODE_DEPTHS << depth
    dfs_recursive(node.parent, depth - 1)
  elsif (node.gone_left && node.gone_right) || (!node.left? && node.gone_right) || (!node.right? && node.gone_left)
    dfs_recursive(node.parent, depth - 1)
  elsif node.left? && !node.gone_left
    node.gone_left = true
    dfs_recursive(node.left, depth + 1)
  elsif node.right? && !node.gone_right
    node.gone_right = true
    dfs_recursive(node.right, depth + 1)
  end
end

# interview cake solution uses a stack to track nodes that we have traversed intsead of adding additional state
# to the nodes. nodes are popped off as we check them and if they are not a leaf, we add their left/right to the
# stack to check the next time through the loop
def balanced?(tree_root)

  # A tree with no nodes is superbalanced, since there are no leaves!
  return true unless tree_root

  # We short-circuit as soon as we find more than 2.
  depths = []

  # We'll treat this array as a stack that will store pairs [node, depth].
  nodes = []
  nodes << [tree_root, 0]

  until nodes.empty?

    # Pop a node and its depth from the top of our stack.
    node, depth = nodes.pop

    # Case: we found a leaf.
    if !node.left && !node.right

      # We only care if it's a new depth.
      unless depths.include?(depth)
        depths.push(depth)

        # Two ways we might now have an unbalanced tree:
        #   1) more than 2 different leaf depths
        #   2) 2 leaf depths that are more than 1 apart
        if depths.length > 2 ||
           depths.length == 2 && (depths[0] - depths[1]).abs > 1
          return false
        end
      end

    # Case: this isn't a leaf - keep stepping down.
    else
      nodes << [node.left, depth + 1] if node.left
      nodes << [node.right, depth + 1] if node.right
    end
  end

  true
end

# Tests

class BinaryTreeNode
  attr_accessor :value, :gone_left, :gone_right
  attr_reader :left, :right, :parent

  def initialize(value, parent = nil)
    @value = value
    @left  = nil
    @right = nil
    @parent = parent
    @gone_left = false
    @gone_right = false
  end

  def insert_left(value)
    @left = BinaryTreeNode.new(value, self)
  end

  def left?
    @left != nil
  end

  def insert_right(value)
    @right = BinaryTreeNode.new(value, self)
  end

  def right?
    @right != nil
  end
end

def run_tests
  desc = 'full tree'
  tree = BinaryTreeNode.new(5)
  left = tree.insert_left(8)
  right = tree.insert_right(6)
  left.insert_left(1)
  left.insert_right(2)
  right.insert_left(3)
  right.insert_right(4)
  result = balanced?(tree)
  assert_true(result, desc)

  desc = 'both leaves at the same depth'
  tree = BinaryTreeNode.new(3)
  left = tree.insert_left(4)
  right = tree.insert_right(2)
  left.insert_left(1)
  right.insert_right(9)
  result = balanced?(tree)
  assert_true(result, desc)

  desc = 'leaf heights differ by one'
  tree = BinaryTreeNode.new(6)
  left = tree.insert_left(1)
  right = tree.insert_right(0)
  right.insert_right(7)
  result = balanced?(tree)
  assert_true(result, desc)

  desc = 'leaf heights differ by two'
  tree = BinaryTreeNode.new(6)
  left = tree.insert_left(1)
  right = tree.insert_right(0)
  right_right = right.insert_right(7)
  right_right.insert_right(8)
  result = balanced?(tree)
  assert_false(result, desc)

  desc = 'three leaves total'
  tree = BinaryTreeNode.new(1)
  left = tree.insert_left(5)
  right = tree.insert_right(9)
  right.insert_left(8)
  right.insert_right(5)
  result = balanced?(tree)
  assert_true(result, desc)

  desc = 'both subtrees superbalanced'
  tree = BinaryTreeNode.new(1)
  left = tree.insert_left(5)
  right = tree.insert_right(9)
  right_left = right.insert_left(8)
  right.insert_right(5)
  right_left.insert_left(7)
  result = balanced?(tree)
  assert_false(result, desc)

  desc = 'both subtrees superbalanced two'
  tree = BinaryTreeNode.new(1)
  left = tree.insert_left(2)
  right = tree.insert_right(4)
  left.insert_left(3)
  left_right = left.insert_right(7)
  left_right.insert_right(8)
  right_right = right.insert_right(5)
  right_right_right = right_right.insert_right(6)
  right_right_right.insert_right(9)
  result = balanced?(tree)
  assert_false(result, desc)

  desc = 'three leaves at different levels'
  tree = BinaryTreeNode.new(1)
  left = tree.insert_left(2)
  left_left = left.insert_left(3)
  left.insert_right(4)
  left_left.insert_left(5)
  left_left.insert_right(6)
  right = tree.insert_right(7)
  right_right = right.insert_right(8)
  right_right_right = right_right.insert_right(9)
  right_right_right.insert_right(10)
  result = balanced?(tree)
  assert_false(result, desc)

  desc = 'only one node'
  tree = BinaryTreeNode.new(1)
  result = balanced?(tree)
  assert_true(result, desc)

  desc = 'linked list tree'
  tree = BinaryTreeNode.new(1)
  right = tree.insert_right(2)
  right_right = right.insert_right(3)
  right_right.insert_right(4)
  result = balanced?(tree)
  assert_true(result, desc)
end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

run_tests
