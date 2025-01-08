# frozen_string_literal: true

# Write an efficient method that checks whether any permutation ↴ of an input string is a palindrome. ↴

# You can assume the input string only contains lowercase letters.

def has_palindrome_permutation?(the_string)
  return true if the_string.empty?

  string_map = {}
  the_string.split('').each do |char|
    string_map[char] = string_map[char] ? string_map[char] += 1 : 1
  end

  if the_string.size.even?
    # if it is even length, it needs to have an even number of each character in it
    string_map.each_value { |v| return false if v.odd? }

  else
    # if its odd, then there needs to be an even number of all characters except one, which will be odd
    odd_char = nil
    string_map.each_value do |v|
      next unless v.odd?
      return false if odd_char

      odd_char = v
    end

    true
  end
end

def palindrome_refactored(the_string)
  string_map = {}

  # true == even, false == odd
  the_string.split('').each do |char|
    string_map[char] = string_map[char] == false
  end

  return true if string_map.values.all?(true)

  true if string_map.values.one? { |v| v == false }
end

require 'set'

palindrome_set = proc do |the_string|
  return true if the_string.empty? || the_string.size == 1

  odd_chars = Set.new

  the_string.split('').each do |char|
    if odd_chars.include?(char)
      odd_chars.delete(char)
    else
      odd_chars.add(char)
    end
  end

  return false if odd_chars.size > 1

  true
end

# Tests

def run_tests(method)
  p method

  desc = 'permutation with odd number of chars'
  result = method.call('aabcbcd')
  assert_true(result, desc)

  desc = 'permutation with even number of chars'
  result = method.call('aabccbdd')
  assert_true(result, desc)

  desc = 'no permutation with odd number of chars'
  result = method.call('aabcd')
  assert_false(result, desc)

  desc = 'no permutation with even number of chars'
  result = method.call('aabbcd')
  assert_false(result, desc)

  desc = 'empty string'
  result = method.call('')
  assert_true(result, desc)

  desc = 'one character string'
  result = method.call('a')
  assert_true(result, desc)
end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

run_tests(method(:has_palindrome_permutation?))
run_tests(method(:palindrome_refactored))
run_tests(palindrome_set)
