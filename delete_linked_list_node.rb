# Delete a node from a singly-linked list, ↴ given only a variable pointing to that node.

require 'byebug'

def delete_node(node_to_delete)

  # Delete the input node from the linked list.
  node_to_delete.value = node_to_delete.next.value
  node_to_delete.next = node_to_delete.next.next
  
  


end


















# Tests

class LinkedListNode
  attr_accessor :value, :next

  def initialize(value, next_node = nil)
    @value = value
    @next = next_node
  end

  def values
    vs = []

    node = self
    while node
      vs << node.value
      node = node.next
    end

    vs
  end
end

def run_tests
  desc = 'node at beginning'
  fourth = LinkedListNode.new(4)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)
  delete_node(first)
  actual = first.values
  expected = [2, 3, 4]
  assert_equal(actual, expected, desc)

  desc = 'node in middle'
  fourth = LinkedListNode.new(4)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)
  delete_node(second)
  actual = first.values
  expected = [1, 3, 4]
  assert_equal(actual, expected, desc)

  desc = 'node at end'
  fourth = LinkedListNode.new(4)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)
  assert_raises(desc) { delete_node(fourth) }

  desc = 'one node in list'
  unique = LinkedListNode.new(1)
  assert_raises(desc) { delete_node(unique) }
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
