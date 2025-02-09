require_relative './linked_list'

# def reverse(head_of_list)

#   # Reverse the linked list in place.
  
#   linked_list_stack = []
#   current_node = head_of_list

#   while current_node
#     linked_list_stack.push(current_node.value)
#     current_node = current_node.next
#   end

#   linked_list_stack.reverse!
#   current_node = head_of_list
#   reversed_node_value = linked_list_stack.pop

#   while current_node
#     current_node.value = reversed_node_value
#     current_node = current_node.next
#     reversed_node_value = linked_list_stack.pop
#   end

  
#   head_of_list
# end

def reverse(head_of_list)
  

  current_node = head_of_list
  previous_node = nil

  while current_node
    next_node = current_node.next
    current_node.next = previous_node
    previous_node = current_node
    current_node = next_node  
  end

  previous_node
end
















# Tests

def run_tests
  desc = 'short linked list'
  second = LinkedListNode.new(2)
  first = LinkedListNode.new(1, second)

  result = reverse(first)
  assert_not_nil(result, desc)

  actual = result.values
  expected = [2, 1]
  assert_equal(actual, expected, desc)

  desc = 'long linked list'
  sixth = LinkedListNode.new(6)
  fifth = LinkedListNode.new(5, sixth)
  fourth = LinkedListNode.new(4, fifth)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)

  result = reverse(first)
  assert_not_nil(result, desc)

  actual = result.values
  expected = [6, 5, 4, 3, 2, 1]
  assert_equal(actual, expected, desc)

  desc = 'one element linked list'
  first = LinkedListNode.new(1)

  result = reverse(first)
  assert_not_nil(result, desc)

  actual = result.values
  expected = [1]
  assert_equal(actual, expected, desc)

  desc = 'empty linked list'
  result = reverse(nil)
  assert_nil(result, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

def assert_nil(value, desc)
  puts "#{desc} ... #{value.nil? ? 'PASS' : "FAIL: #{value} is not nil"}"
end

def assert_not_nil(value, desc)
  puts "#{desc} ... #{value.nil? ? "FAIL: #{value} is nil" : 'PASS'}"
end

run_tests
