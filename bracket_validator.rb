<<~DESC
  You're working with an intern that keeps coming to you with JavaScript code that won't run because the braces, brackets, and parentheses are off. To save you both some time, you decide to write a braces/brackets/parentheses validator.

Let's say:

'(', '{', '[' are called "openers."
')', '}', ']' are called "closers."
Write an efficient method that tells us whether or not an input string's openers and closers are properly nested.

Examples:

"{ [ ] ( ) }" should return true
"{ [ ( ] ) }" should return false
"{ [ }" should return false
DESC

def valid?(code)

  # Determine if the input code is valid.
  opener_stack = []
  opener_closer_map = {
    '}' => '{',
    ']' => '[',
    ')' => '('
  }

  (code.size).times do |index|
    char = code[index]

    if opener_closer_map.value?(char)
      opener_stack.push(char)
    elsif opener_closer_map.key?(char)
      opening_char = opener_stack.pop

      return false unless opening_char == opener_closer_map[char]
    end
  end
  
  opener_stack.empty?
end

# Tests

def run_tests
  desc = 'valid short code'
  result = valid?('()')
  assert_true(result, desc)

  desc = 'valid longer code'
  result = valid?('([]{[]})[]{{}()}')
  assert_true(result, desc)

  desc = 'interleaved openers and closers'
  result = valid?('([)]')
  assert_false(result, desc)

  desc = 'mismatched opener and closer'
  result = valid?('([][]}')
  assert_false(result, desc)

  desc = 'missing closer'
  result = valid?('[[]()')
  assert_false(result, desc)

  desc = 'extra closer'
  result = valid?('[[]]())')
  assert_false(result, desc)

  desc = 'empty string'
  result = valid?('')
  assert_true(result, desc)
end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

run_tests
