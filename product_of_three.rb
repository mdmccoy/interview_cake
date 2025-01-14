# frozen_string_literal: true

# Given an array of integers, find the highest product you can get from three of the integers.

# The input array_of_ints will always have at least three integers.

def highest_product_of_3(array_of_ints)
  # Works but is 'slow' since we're using rubies sort and reverse methods which must go through the array each time
  raise 'Error' if array_of_ints.size < 3

  # array_of_ints = array_of_ints.sort.reverse

  # # if we have exactly 2 negatives, treat them as positives
  # if array_of_ints[-1] < 0 && array_of_ints[-2] < 0 && array_of_ints[-3] > 0
  #   array_of_ints.last(2).each do |int|
  #     array_of_ints.push(int * -1)
  #   end
  # end

  # array_of_ints = array_of_ints.sort.reverse

  # array_of_ints[0..2].inject(:*)
  #
  #
  #
  #
  #
  # Attempt #1 at O(n) is flawed when it comes to arrays of negative numbers

  # p array_of_ints.sort.reverse

  # p array_of_ints[0..2].sort.reverse

  # largest, second_largest, third_largest = array_of_ints[0..2].sort.reverse
  # most_negative, second_most_negative, third_most_negative = array_of_ints[0..2].sort
  # number_of_negatives = 0
  # number_of_negatives += 1 if most_negative < 0
  # number_of_negatives += 1 if second_most_negative < 0
  # number_of_negatives += 1 if third_most_negative < 0

  # p largest, second_largest, third_largest

  # array_of_ints[3..].each do |int|
  #   if int < 0
  #     number_of_negatives += 1
  #     if int <= most_negative
  #       second_most_negative = most_negative
  #       most_negative = int
  #     elsif int > most_negative && int < second_most_negative
  #       second_most_negative = int
  #     end
  #   else
  #     if int >= largest
  #       third_largest = second_largest
  #       second_largest = largest
  #       largest = int
  #     elsif int < largest && int >= second_largest
  #       third_largest = second_largest
  #       second_largest = int
  #     elsif int < second_largest && int > third_largest
  #       third_largest = int
  #     end
  #   end
  # end

  # p largest, second_largest, third_largest

  # if number_of_negatives == 2
  #   [largest, second_largest, third_largest, most_negative.abs, second_most_negative.abs].sort.reverse.first(3).inject(:*)
  # else
  #   largest * second_largest * third_largest
  # end

  p array_of_ints

  highest_product_of_2 = array_of_ints.first(2).inject(:*)
  lowest_product_of_2 = array_of_ints.first(2).inject(:*)
  highest_product_of_3 = array_of_ints.first(3).inject(:*)
  highest = array_of_ints.first(2).max
  lowest = array_of_ints.first(2).min

  array_of_ints[2..].each do |int|
      highest_product_of_3 = [(int * highest_product_of_2), (int * lowest_product_of_2), highest_product_of_3].max

      highest_product_of_2 = [(int * highest), (int * lowest), highest_product_of_2].max

      lowest_product_of_2 = [(int * highest), (int * lowest), lowest_product_of_2].min

      highest = int if int > highest
      lowest = int if int < lowest
  end
  highest_product_of_3
end

def run_tests
  actual = highest_product_of_3([1, 2, 3, 4])
  expected = 24
  assert_equal(actual, expected, 'short array')

  actual = highest_product_of_3([6, 1, 3, 5, 7, 8, 2])
  expected = 336
  assert_equal(actual, expected, 'longer array')

  actual = highest_product_of_3([-5, 4, 8, 2, 3])
  expected = 96
  assert_equal(actual, expected, 'array has one negative')

  actual = highest_product_of_3([-10, 1, 3, 2, -10])
  expected = 300
  assert_equal(actual, expected, 'array has two negatives')

  actual = highest_product_of_3([-5, -1, -3, -2])
  expected = -6
  assert_equal(actual, expected, 'array is all negatives')

  # assert_raises('empty array raises error') do
  #   highest_product_of_3([])
  # end

  # assert_raises('one number raises error') do
  #   highest_product_of_3([1])
  # end

  # assert_raises('two numbers raises error') do
  #   highest_product_of_3([1, 1])
  # end
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

def assert_raises(desc)
  yield
  puts "#{desc} ... FAIL"
rescue StandardError
  puts "#{desc} ... PASS"
end

run_tests
