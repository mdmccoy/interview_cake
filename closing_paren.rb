<<~DESC
  I like parentheticals (a lot).

"Sometimes (when I nest them (my parentheticals) too much (like this (and this))) they get confusing."

Write a method that, given a sentence like the one above, along with the position of an opening parenthesis, finds the corresponding closing parenthesis.

Example: if the example string above is input with the number 10 (position of the first parenthesis), the output should be 79 (position of the last parenthesis).
DESC


def get_closing_paren(sentence, opening_paren_index)

  # Find the position of the matching closing parenthesis.
  # O(n) time and space
  # opening_paren_index_stack = []
  # sentence.split('').each_with_index do |char, index|
    # opening_paren_index_stack << index if char == '('
    # return index if char == ')' && opening_paren_index_stack.pop == opening_paren_index
  # end
  # raise "no matching closer"
  

  # What number paren is the opening_paren_index
  number_of_opening_parens = 0

  opening_paren_index.upto(sentence.size - 1) do |index|
    char = sentence[index]
    if char == '('
      number_of_opening_parens += 1
    elsif char == ')'
      number_of_opening_parens -= 1
      return index if number_of_opening_parens == 0
    end
  end
  
  raise "no matching closer"
end


















# Tests

def run_tests
  desc = 'all openers then closers'
  actual = get_closing_paren('((((()))))', 2)
  expected = 7
  assert_equal(actual, expected, desc)

  desc = 'mixed openers and closers'
  actual = get_closing_paren('()()((()()))', 5)
  expected = 10
  assert_equal(actual, expected, desc)

  desc = 'no matching closer'
  assert_raises(desc) { get_closing_paren('()(()', 2) }
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
