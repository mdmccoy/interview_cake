# You have an array of integers, and for each index you want to find the product of every integer except the integer at that index.

# Write a method get_products_of_all_ints_except_at_index() that takes an array of integers and returns an array of the products.

# For example, given:

#   [1, 7, 3, 4]

# your method would return:

#   [84, 12, 28, 21]

# by calculating:

#   [7 * 3 * 4,  1 * 3 * 4,  1 * 7 * 4,  1 * 7 * 3]

# Here's the catch: You can't use division in your solution!

def get_products_of_all_ints_except_at_index(array_of_ints)
  raise 'error' if array_of_ints.size < 2

  # return_array = []
  # array_of_ints.each_with_index do |int, index|
  #   product = 1
  #   array_of_ints.each_with_index do |next_int, inner_index|
  #     next if inner_index == index

  #     product *= next_int
  #   end

  #   return_array << product
  # end

  # return_array
  # 
  #
  # If we can solve this by going through one time, what do we need to keep track of?
  # The running product of all numbers before us
  # The product of all integers after us

  products_of_all_ints_before_index = []
  product = 1
  array_of_ints.each_with_index do |int, index|
    products_of_all_ints_before_index << product
    product *= int
  end

  products_of_all_ints_except_at_index = []
  product_so_far = 1
  i = array_of_ints.length - 1
  while i >= 0
    products_of_all_ints_except_at_index[i] = product_so_far * products_of_all_ints_before_index[i]
    product_so_far *= array_of_ints[i]
    i -= 1
  end

  products_of_all_ints_except_at_index
end

def run_tests
  desc = 'short array'
  actual = get_products_of_all_ints_except_at_index([1, 2, 3])
  expected = [6, 3, 2]
  assert_equal(actual, expected, desc)

  desc = 'longer array'
  actual = get_products_of_all_ints_except_at_index([8, 2, 4, 3, 1, 5])
  expected = [120, 480, 240, 320, 960, 192]
  assert_equal(actual, expected, desc)

  desc = 'array has one zero'
  actual = get_products_of_all_ints_except_at_index([6, 2, 0, 3])
  expected = [0, 0, 36, 0]
  assert_equal(actual, expected, desc)

  desc = 'array has two zeros'
  actual = get_products_of_all_ints_except_at_index([4, 0, 9, 1, 0])
  expected = [0, 0, 0, 0, 0]
  assert_equal(actual, expected, desc)

  desc = 'one negative number'
  actual = get_products_of_all_ints_except_at_index([-3, 8, 4])
  expected = [32, -12, -24]
  assert_equal(actual, expected, desc)

  desc = 'all negative numbers'
  actual = get_products_of_all_ints_except_at_index([-7, -1, -4, -2])
  expected = [-8, -56, -14, -28]
  assert_equal(actual, expected, desc)

  desc = 'error with empty array'
  assert_raises(desc) { get_products_of_all_ints_except_at_index([]) }

  desc = 'error with one number'
  assert_raises(desc) { get_products_of_all_ints_except_at_index([1]) }
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
