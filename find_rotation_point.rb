# I want to learn some big words so people think I'm smart.

# I opened up a dictionary to a page in the middle and started flipping through, looking for words I didn't know. I put each word I didn't know at increasing indices in a huge array I created in memory. When I reached the end of the dictionary, I started from the beginning and did the same thing until I reached the page I started at.

# Now I have an array of words that are mostly alphabetical, except they start somewhere in the middle of the alphabet, reach the end, and then start from the beginning of the alphabet. In other words, this is an alphabetically ordered array that has been "rotated." For example:

#   words = [
#     'ptolemaic',
#     'retrograde',
#     'supplant',
#     'undulate',
#     'xenoepist',
#     'asymptote',  # <-- rotates here!
#     'babka',
#     'banoffee',
#     'engender',
#     'karpatka',
#     'othellolagkage',
# ]

# Write a method for finding the index of the "rotation point," which is where I started working from the beginning of the dictionary. This array is huge (there are lots of words I don't know) so we want to be efficient here.

# To keep things simple, you can assume all words are lowercase. 

# MODIEFD Binary search problem


def find_rotation_point(words)

  # Find the rotation point in the array.
  # Binary search works by starting in the middle of the sorted array and checking to see if what we are looking for
  # is in the right half (top) or left half (bottom)
  # 
  # Problem #1 is our array is not exactly sorted.
  # We know that we started in the middle of the dictionary, so, our earliest alphabetical word will be after our latest alphabetical word ( a will be AFTER z)
  # So if we pick a spt in the middle... how do we know which direction to go ?
  # 
  #
  # One solution would be to just sort the array, take the item at the end, and then find it's position in the unsorted array. The index to the right of it is the pivot point.
  # This is probably not the most efficient becuase we have to sort the array O(n log n) then iterate through the array O(n)
  # 
  # words.index(words.sort.last) + 1
  # 
  # Slightly more efficient would be iterating through the array to find the "largest" word AKA last one alphabetically. This would be O(n) since we have to go all the way through.
  
  # We know we've found the pivot point if the items on each side are "higher" aka AFTER us in the alphabet [j,w,x,y,z,a,b] <- a is our pivot because z and b are both after it
  # 
  # If pivot point is to the right of my guess, the item at the end will be lower than my pivot point. If its not to the right then its to the LEFT!
  # 
  # [z,a,b,c,d,e,f,g]
  # 

  
  floor_index = 0
  ceiling_index = words.size - 1
  last_word = words.last

  # if words.size == 2
  #  return words.first > words.last ? 1 : 0
  # end
  
  # While we still have at least one item between our floor and ceiling
  # If we dont, we didnt find the item.
  while floor_index < ceiling_index

    # calculate our indexes for searching
    # distance = ceiling_index - floor_index
    # half_distance = distance / 2
    # guess_index = floor_index + half_distance
    guess_index = (floor_index + ceiling_index) / 2

    # get the things to check
    ceiling_word = words[ceiling_index]
    guess_word = words[guess_index]
    guess_array = words[floor_index..ceiling_index]


    puts "Remaining Array = #{guess_array}"
    puts "Guessing #{guess_word}"

    # Special case for array of 2 items
    # if guess_array.size == 2
    #   p "Two item guess so just check which is smaller"
    #   return guess_array.first > guess_array.last ? ceiling_index : floor_index
    # end

    # # First check to see if we have found the pivot point
    # # We know we've found the pivot point if the items on each side are "higher" aka AFTER us in the alphabet
    # # Probably some edge cases here about being at the front or end of the array to consider
    # if guess_word < words[guess_index + 1] && guess_word < words[guess_index - 1]
    #   return guess_index
    # end

    # If pivot point is to the right of my guess, the item at the end will be lower than my pivot point. If its not to the right then its to the LEFT!
    # In other words, the pivot point is to the right if the current item is MORE than the last item
    if last_word < guess_word
      # search to the right of guess_index
      p "move to the right"
      floor_index = guess_index
    else
      # search to the left of guess index
      p "move to the left"
      ceiling_index = guess_index
    end

    # if we have converved then we have found the pivot point, and it will be the ceiling
    return ceiling_index if floor_index + 1 == ceiling_index
  end
end

# Tests

def run_tests
  desc = 'small array'
  actual = find_rotation_point(['cape', 'cake'])
  expected = 1
  assert_equal(actual, expected, desc)

  desc = 'medium array'
  actual = find_rotation_point(['grape', 'orange', 'plum', 'radish', 'apple'])
  expected = 4
  assert_equal(actual, expected, desc)

  desc = 'large array'
  actual = find_rotation_point(['ptolemaic', 'retrograde', 'supplant',
                                'undulate', 'xenoepist', 'asymptote',
                                'babka', 'banoffee', 'engender',
                                'karpatka', 'othellolagkage'])
  expected = 5
  assert_equal(actual, expected, desc)

  # Are we missing any edge cases?
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
