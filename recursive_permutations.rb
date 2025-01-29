

# Write a recursive method for generating all permutations of an input string. Return them as a set.

# Don't worry about time or space complexity—if we wanted efficiency we'd write an iterative version.

# To start, assume every character in the input string is unique.

# Your method can have loops—it just needs to also be recursive.

require 'set'

# def get_permutations(string)
#   return Set.new [""] if string.empty?
#   return Set.new [string] if string.size == 1

#   # Generate all permutations of the input string.
#   string_array = string.split('')
#   string_array.map do |char|
#     puts "Permutations of #{char} + #{string_array - [char]}"
#     remaining_chars = string_array - [char]

#     if remaining_chars.size == 1
#       RETURN_SET.add(string_array.first + string_array.last)
#       RETURN_SET.add(string_array.last + string_array.first)
#     elsif remaining_chars.size == 2
      
#       RETURN_SET.add(char + remaining_chars.first + remaining_chars.last)
#       RETURN_SET.add(char + remaining_chars.last + remaining_chars.first)
      
#     else
#       get_permutations(string_array - char).map { |perm| char + perm }
#     end
#   end

#   RETURN_SET.flatten
# end

def get_permutations(string)
  if string.length <= 1
    return Set.new [string]
  end

  all_chars_except_last = string[0..-2]
  last_char = string[-1]

  permutations_of_all_chars_except_last = get_permutations(all_chars_except_last)

  permutations = Set.new
  permutations_of_all_chars_except_last.each do |permutation_of_all_chars_except_last|
    (0..all_chars_except_last.length).each do |position|
      permutation = permutation_of_all_chars_except_last[0...position] + last_char + permutation_of_all_chars_except_last[position..-1]
      permutations.add(permutation)
    end
  end

  permutations
end

# Tests

def run_tests
  desc = 'empty string'
  actual = get_permutations('')
  expected = Set.new([''])
  assert_equal(actual, expected, desc)

  desc = 'one character string'
  actual = get_permutations('a')
  expected = Set.new(['a'])
  assert_equal(actual, expected, desc)

  desc = 'two character string'
  actual = get_permutations('ab')
  expected = Set.new(['ab', 'ba'])
  assert_equal(actual, expected, desc)

  desc = 'three character string'
  actual = get_permutations('abc')
  expected = Set.new(['abc', 'acb', 'bac', 'bca', 'cab', 'cba'])
  assert_equal(actual, expected, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
