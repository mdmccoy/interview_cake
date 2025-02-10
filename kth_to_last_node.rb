require_relative './linked_list'

def kth_to_last_node(k, head)
  raise "error" if k == 0

  # Return the kth to last node in the linked list.

  # Brute Force approach in O(n) time and space
  # node = head
  # list_stack = []
  # while node
  #   list_stack.push(node)
  #   node = node.next
  # end

  # raise "error" if k > list_stack.size

  # list_stack[list_stack.size - k]
  
  # n = 10
  # 2nd to last
  # item at index 8
  # n - k = index
   
  # Two runner approach:
  # Move one pointer ahead k steps at a time, another ahead one step at a time
  # Fast runner will find the length, which lets us know which node to get.

  # fast_runner = head
  # list_size = 1
  # slow_runner = head
  # slow_runner_position = 1

  # while fast_runner
  #   k.times do
  #     fast_runner = fast_runner.next
  #     list_size += 1 if fast_runner
  #   end

  #   if fast_runner
  #     slow_runner = slow_runner.next
  #     slow_runner_position += 1
  #   end
  # end

  # desired_position = (list_size - k) + 1 # 1 indexed
  # move_ahead = desired_position - slow_runner_position
  # move_ahead.times { slow_runner = slow_runner.next }

  # slow_runner.value
  # 
  
  # Interview Cake solution 1
  # Walk through the list to get the size, but instead of storing each node, just walk through it again
  
  # current_node = head
  # size = 1
  # while current_node = current_node.next
  #   size += 1
  # end

  # raise 'error' if k > size

  # move_ahead_times = size - k

  # return_node = head
  # move_ahead_times.times { return_node = return_node.next }
  # return_node.value
   
  # Interview Cake solution 2, use a stick k size long.
  # Similar to 2 runner approach, so I could have probably refactored that down further

  right_node = head
  left_node = head

  # move to the kth item, starting at the head
  (k-1).times do
    right_node = right_node.next
    raise 'k larger than size' if right_node.nil?
  end

  while right_node = right_node.next
    left_node = left_node.next
  end

  left_node.value
end


# Tests

def run_tests
  fourth = LinkedListNode.new(4)
  third = LinkedListNode.new(3, fourth)
  second = LinkedListNode.new(2, third)
  first = LinkedListNode.new(1, second)

  desc = 'first to last node'
  actual = kth_to_last_node(1, first)
  expected = fourth.value
  assert_equal(actual, expected, desc)

  desc = 'second to last node'
  actual = kth_to_last_node(2, first)
  expected = third.value
  assert_equal(actual, expected, desc)

  desc = 'first node'
  actual = kth_to_last_node(4, first)
  expected = first.value
  assert_equal(actual, expected, desc)

  desc = 'k greater than linked list length'
  assert_raises(desc) { kth_to_last_node(5, first) }

  desc = 'k is zero'
  assert_raises(desc) { kth_to_last_node(0, first) }
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
