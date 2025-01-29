# Using this, find a duplicate integer in O(n)O(n) time while keeping our space cost at O(1)O(1). Just like before, don't modify the input.

class Array
  def item_at_position(x, print = false)    
    if print
      p self
      puts "Accessing position #{x}"
    end

    self[x-1]
  end
end

# def find_duplicate(int_array)

#   # Find a number that appears more than once... in O(n) time.
#   # have_seen_int = {}

#   # EZ Answer in O(n) space/time
#   # int_array.each do |int|
#   #   return int if have_seen_int.key?(int)

#   #   have_seen_int[int] = true
#   # end

#   loop_size = find_loop_size(int_array)

#   # Use stick method to find first node in cycle
#   # Start one pointer at head, one pointer loop_size steps forward in list
#   head_position = int_array.size
#   forward_postiion = int_array.item_at_position(head_position)
#   (loop_size - 1).times do |_step_number| # we've taken first step
#     forward_postiion = int_array.item_at_position(forward_postiion)
#   end

#   # When they converge we have found first item in loop
#   until int_array.item_at_position(head_position) == int_array.item_at_position(forward_postiion)
#     head_position = int_array.item_at_position(head_position)
#     forward_postiion = int_array.item_at_position(forward_postiion)
#   end
     
#   int_array.item_at_position(head_position)
# end

# def find_loop_size(int_array)
#   n = int_array.size - 1
#   new_position = int_array.last
#   loop_size = 1

#   # start at head and walk n times, new_pos is the first step
#   n.times do |_step_count|
#     new_position = int_array.item_at_position(new_position)
#   end

#   value_in_loop = new_position

#   # walk through list until we get back to our value to find size of loop
#   until value_in_loop == int_array.item_at_position(new_position)
#     loop_size += 1

#     new_position = int_array.item_at_position(new_position)
#   end

#   loop_size
# end

# range 1..n
# size = n + 1 | size - 1 = n
def find_duplicate(int_array)
  n = int_array.size - 1

  # This is the head. Walk n items into list to be in a cycle
  position_in_cycle = n + 1
  n.times do
    position_in_cycle = int_array.item_at_position(position_in_cycle)
  end

  # Find length of cycle by starting at a position in the cycle and counting
  # steps to get back to that position
  saved_position_in_cycle = position_in_cycle
  current_position_in_cycle = int_array.item_at_position(position_in_cycle)
  cycle_step_count = 1

  while current_position_in_cycle != saved_position_in_cycle
    current_position_in_cycle = int_array.item_at_position(current_position_in_cycle)
    cycle_step_count += 1
  end

  # Find the first node of the cycle by using two pointers
  # 1st at head
  # 2nd cycle_step_count into list
  pointer_start = n + 1
  pointer_ahead = n + 1
  cycle_step_count.times do
    pointer_ahead = int_array.item_at_position(pointer_ahead)
  end

  # Advance pointers until they are at same position in cycle. This will be the start.
  while pointer_start != pointer_ahead
    pointer_start = int_array.item_at_position pointer_start
    pointer_ahead = int_array.item_at_position pointer_ahead
  end

  pointer_start
end


# find_duplicate([3,4,2,3,1,5])
# find_duplicate([3,1,2,2])















# Tests

def run_tests
  desc = 'test array'
  actual = find_duplicate([3,4,2,3,1,5])
  expected = 3
  assert_equal(actual, expected, desc)

  desc = 'just the repeated number'
  actual = find_duplicate([1, 1])
  expected = 1
  assert_equal(actual, expected, desc)

  desc = 'short array'
  actual = find_duplicate([1, 2, 3, 2])
  expected = 2
  assert_equal(actual, expected, desc)

  desc = 'medium array'
  actual = find_duplicate([1, 2, 5, 5, 5, 5])
  expected = 5
  assert_equal(actual, expected, desc)

  desc = 'long array'
  actual = find_duplicate([4, 1, 4, 8, 3, 2, 7, 6, 5])
  expected = 4
  assert_equal(actual, expected, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
