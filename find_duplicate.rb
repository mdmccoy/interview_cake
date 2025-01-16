

# Find a duplicate, Space Edition™.

# We have an array of integers, where:

#     The integers are in the range 1..n
#     The array has a length of n+1

# It follows that our array has at least one integer which appears at least twice. But it may have several duplicates, and each duplicate may appear more than twice.

# Write a method which finds an integer that appears more than once in our array. Don't modify the input! (If there are multiple duplicates, you only need to find one of them.)

# We're going to run this method on our new, super-hip MacBook Pro With Retina Display™. Thing is, the damn thing came with the RAM soldered right to the motherboard, so we can't upgrade our RAM. So we need to optimize for space!
# 
#
# Since we know that the numbers are in range 1..n, and that the lenghts of the array is n+1
# That means that we can figure out n == array.size
# So the numbers in the range of 1..array.size How does that help us search for a duplicate number?

# def find_repeat(numbers)
#   duplicate = nil

#   n = numbers.size - 1
#   bottom_range = 1..(n / 2)
#   top_range = ((n / 2)+1)..n
#   x = 0

#   while x < 10
#     bottom_range_expected = bottom_range.size
#     top_range_expected = top_range.size
#     bottom_range_amount = 0
#     top_range_amount = 0

#     numbers.each do |num|
#       next unless bottom_range.include?(num) || top_range.include?(num)
  
#       bottom_range.include?(num) ? bottom_range_amount += 1 : top_range_amount += 1
#     end

#     if bottom_range_expected == 1 && bottom_range_amount > 1
#       p "Duplicate found in bottom range"
#       duplicate = bottom_range.first
#       break
#     elsif top_range_expected == 1 && top_range_amount > 1
#       duplicate = top_range.first
#       p "Duplicate found in top range"
#       break
#     end
  
#     print_vars(bottom_range, bottom_range_expected, bottom_range_amount)
#     print_vars(top_range, top_range_expected, top_range_amount)
  
#     if bottom_range_amount > bottom_range_expected
#       n = bottom_range.last
#       bottom_range = 1..(n / 2)
#       top_range = ((n / 2)+1)..n
#     else
#       if top_range.size == 2
#         bottom_range = top_range.first..top_range.first
#         top_range = top_range.last..top_range.last
#       else
#         bottom_range = top_range.first..(top_range.first + top_range.size / 2)
#         top_range = (bottom_range.last + 1)..top_range.last
#       end
#     end

#     x += 1
#   end

#   duplicate
# end

# def print_vars(range, expected, amount)
#   p "range #{range}"
#   p "range expected #{expected}"
#   p "range amount #{amount}"  
# end

# interview cake answer
def find_repeat(numbers)
  floor = 1
  ceiling = numbers.size - 1

  while floor < ceiling
    midpoint = floor + (ceiling - floor) / 2
    lower_range_floor = floor
    lower_range_ceiling = midpoint
    upper_range_floor = midpoint + 1
    upper_range_ceiling = ceiling

    items_in_lower_range = numbers.count do |num|
      num >= lower_range_floor && num <= lower_range_ceiling
    end

    expected_numbers_in_lower_range = lower_range_ceiling - lower_range_floor + 1

    if items_in_lower_range > expected_numbers_in_lower_range
      floor = lower_range_floor
      ceiling = lower_range_ceiling
    else
      floor = upper_range_floor
      ceiling = upper_range_ceiling
    end
  end

  floor
end


# Tests

def run_tests
  desc = 'just the repeated number'
  actual = find_repeat([1, 1])
  expected = 1
  assert_equal(actual, expected, desc)

  desc = 'short array'
  actual = find_repeat([1, 2, 3, 2])
  expected = 2
  assert_equal(actual, expected, desc)

  desc = 'medium array'
  actual = find_repeat([1, 2, 5, 5, 5, 5])
  expected = 5
  assert_equal(actual, expected, desc)

  desc = 'long array'
  actual = find_repeat([4, 1, 4, 8, 3, 2, 7, 6, 5])
  expected = 4
  assert_equal(actual, expected, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
