def reverse!(string, left_index, right_index)
  while left_index < right_index
    temp_1 = string[left_index]
    temp_2 = string[right_index]

    string[left_index] = temp_2
    string[right_index] =  temp_1


    left_index += 1
    right_index -= 1
  end
  

  string
end

def reverse_words!(message)
  p message

  # Decode the message by reversing the words.
  reverse!(message, 0, message.size - 1)

  p message


  # start of the first word
  left_index = 0

  # current position in the the string
  cursor = 0


  while cursor <= message.size - 1
    if message[cursor] == ' '
      p message[left_index..(cursor - 1)]

      reverse!(message, left_index, cursor - 1)

      p message[left_index..(cursor - 1)]

      left_index = cursor + 1
    elsif cursor == message.size - 1
      p message

      reverse!(message, left_index, cursor)

      p message
    end

    cursor += 1
  end

  message
end


# Tests

def run_tests
  desc = 'one word'
  message = 'vault'
  reverse_words!(message)
  expected = 'vault'
  assert_equal(message, expected, desc)

  desc = 'two words'
  message = 'thief cake'
  reverse_words!(message)
  expected = 'cake thief'
  assert_equal(message, expected, desc)

  desc = 'three words'
  message = 'one another get'
  reverse_words!(message)
  expected = 'get another one'
  assert_equal(message, expected, desc)

  desc = 'multiple words same length'
  message = 'rat the ate cat the'
  reverse_words!(message)
  expected = 'the cat ate the rat'
  assert_equal(message, expected, desc)

  desc = 'multiple words different lengths'
  message = 'yummy is cake bundt chocolate'
  reverse_words!(message)
  expected = 'chocolate bundt cake is yummy'
  assert_equal(message, expected, desc)

  desc = 'empty string'
  message = ''
  reverse_words!(message)
  expected = ''
  assert_equal(message, expected, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
