def find_duplicate(int_array)

  # Find a number that appears more than once... in O(n) time.
  # Integers are in the range 1..n
  # The array has length n + 1
  # 
  # The array can be imagined as a linked list. The interger is the value, which points to
  # value-eth node in the list. I.E value = 5, node points to position = 5
  # Positions start at 1, not 0. position = index + 1

  # A duplicate number means we have two nodes pointing to the same node, AKA a loop.
  # We know the head is the last item in the array since we are in range 1..n, and have length n+1
  # 1..n does not include n+1, so, the last item is our head. 
  #
  # We know we will be in the loop if we advance n nodes into the list from the head
  # Because... we know there is a loop somewhere? So lets go as far into it as we know
  # 
  # Then we can find the loop size by moving ahead until we get back to the same position
  # 
  # Then we can find the head of the loop by advancing a "stick" of length loop size, through
  # the list. The position of the head, is our duplicate number, since two items point to it
  # The item that got us into the loop, and the item in the loop that points back to the head
  

  # int_array = [5,4,3,5,1,2]

  # n + 1 = int_array.size
  n = int_array.size - 1
  head = int_array.last
  
  # get into the loop by advancing n times into the list
  position = head  
  n.times do
    position = int_array.item_at_position(position)
  end
  position_inside_loop = position
  # puts "Does 1 == #{position_inside_loop}"


  # find the loop size by moving ahead until we get back to position_inside_loop
  loop_size = 1
  next_position = int_array.item_at_position(position)
  until next_position == position_inside_loop
    next_position = int_array.item_at_position(next_position)
    loop_size += 1
  end
  # puts "Does 2 == #{loop_size}"

  # find the position of the head (our duplicate number) by advancing a stick of loop_size
  #   Advance loop_size into the list
  left_side = head
  right_side = head
  loop_size.times do
    right_side = int_array.item_at_position(right_side)
  end
  # puts "Does 5 == #{right_side}"

  # Advance right_side and left_side until they converge
  # p left_side
  # p right_side
  until right_side == left_side
    left_side = int_array.item_at_position(left_side)
    right_side = int_array.item_at_position(right_side)
  end

  left_side
end


# In order to avoid having to constaly account for position = index + 1
# Lets monkey patch the array class to do that work for us
class Array
  # position = index + 1
  # position - 1 = index
  def item_at_position(n)
    self[n - 1]
  end
end















# Tests

def run_tests
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
