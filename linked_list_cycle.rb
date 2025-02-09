require_relative './linked_list'

# def contains_cycle?(first_node)
#   # Check if the linked list contains a cycle.
#   list_of_object_ids = []
#   while first_node
#     return true if list_of_object_ids.include?(first_node.object_id)

#     list_of_object_ids << first_node.object_id
#     first_node = first_node.next
#   end

#   false
# end

def contains_cycle?(first_node)
  return false if (move_by_1 = first_node).nil?
  
  return false if (move_by_2 = first_node.next).nil?

  while move_by_2
    return true if move_by_1 == move_by_2

    move_by_1 = move_by_1.next
    move_by_2 = move_by_2&.next&.next
  end

  false
end
















# Tests

def run_tests
  desc = 'linked list with no cycle'
  fourth = LinkedListNode.new(4)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)
  result = contains_cycle?(first)
  assert_false(result, desc)

  desc = 'cycle loops to beginning'
  fourth = LinkedListNode.new(4)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)
  fourth.next = first
  result = contains_cycle?(first)
  assert_true(result, desc)

  desc = 'cycle loops to middle'
  fifth = LinkedListNode.new(5)
  fourth = LinkedListNode.new(4, fifth)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)
  fifth.next = third
  result = contains_cycle?(first)
  assert_true(result, desc)

  desc = 'two node cycle at end'
  fifth = LinkedListNode.new(5)
  fourth = LinkedListNode.new(4, fifth)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)
  fifth.next = fourth
  result = contains_cycle?(first)
  assert_true(result, desc)

  desc = 'empty list'
  result = contains_cycle?(nil)
  assert_false(result, desc)

  desc = 'one element linked list no cycle'
  first = LinkedListNode.new(1)
  result = contains_cycle?(first)
  assert_false(result, desc)

  desc = 'one element linked list cycle'
  first = LinkedListNode.new(1)
  first.next = first
  result = contains_cycle?(first)
  assert_true(result, desc)
end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

run_tests
