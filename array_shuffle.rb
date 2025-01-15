
# Write a method for doing an in-place ↴ shuffle of an array.

# The shuffle must be "uniform," meaning each item in the original array must have the same probability of ending up in each spot in the final array.

# Assume that you have a method get_random(floor, ceiling) for getting a random integer that is >= floor and <= ceiling.

def shuffle(array)

  # Shuffle the input in place.
  new_array = []
  array_size = array.size - 1

  # while array_size >= 0
  #   take_index = rand(0..array_size)
  #   new_array << array[take_index]

  #   array.delete_at(take_index)

  #   array_size -= 1
  # end
  

  array.each_with_index do |_item, index|
    break if index == array_size

    take_index = rand(index..array_size)

    value = array[take_index]
    array.delete_at(take_index)
    array.prepend(value)
  end

  array
end

sample_array = [1, 2, 3, 4, 5]
puts "Sample array: #{sample_array}"

puts 'Shuffling sample array...'
shuffle(sample_array)
puts sample_array.inspect
