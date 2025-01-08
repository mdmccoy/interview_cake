require 'benchmark'
require 'benchmark/memory'
require 'set'

def can_two_movies_fill_flight?(movie_lengths, flight_length)

  # Determine if two movie runtimes add up to the flight length.
  
  # Brute force method, double looop through movie_lengths to see if
  # any combination of two items equals flight_length. O(n^3) because
  # we have to go through movie_lengths twice to determine
   
  # movie_lengths.each_with_index do |movie, i|
  #   movie_lengths[i+1..].each do |second_movie|
  #     return true if movie + second_movie == flight_length
  #   end
  # end  
   

  # my solution using a hash to achieve O(n) time. I think this costs slightly
  # more in space beacuse I'm storing a value, where as using a set stores
  # only the keys.
  movie_map = {}
  movie_lengths.each do |movie|
    # put the movie in our map
    movie_map[movie] = movie_map.include?(movie) ? movie_map[movie] + 1 : 1

    remaining_length = flight_length - movie

    if remaining_length == movie
      # if remaining lenght == movie aka half the flight 
      # make sure we have 2 movies of the same time
      return true if movie_map[remaining_length] > 1
    elsif movie_map[remaining_length]
      return true
    end
  end

  false
end

# interview_cake solution for comparison
def can_two_movies_fill_flight_set?(movie_lengths, flight_length)

  # Movie lengths we've seen so far.
  movie_lengths_seen = Set.new

  movie_lengths.any? do |first_movie_length|

    matching_second_movie_length = flight_length - first_movie_length

    if movie_lengths_seen.include?(matching_second_movie_length)
      # We found the match.
      true
    else
      movie_lengths_seen.add(first_movie_length)
      false
    end
  end
end

def run_tests
  desc = 'short flight'
  result = can_two_movies_fill_flight?([2, 4], 1)
  assert_false(result, desc)

  desc = 'long flight'
  result = can_two_movies_fill_flight?([2, 4], 6)
  assert_true(result, desc)

  desc = 'one movie half flight length'
  result = can_two_movies_fill_flight?([3, 8], 6)
  assert_false(result, desc)

  desc = 'two movies half flight length'
  result = can_two_movies_fill_flight?([3, 8, 3], 6)
  assert_true(result, desc)

  desc = 'lots of possible pairs'
  result = can_two_movies_fill_flight?([1, 2, 3, 4, 5, 6], 7)
  assert_true(result, desc)

  desc = 'not using first movie'
  result = can_two_movies_fill_flight?([4, 3, 2], 5)
  assert_true(result, desc)

  desc = 'multiple movies shorter than flight'
  result = can_two_movies_fill_flight?([5, 6, 7, 8], 9)
  assert_false(result, desc)

  desc = 'only one movie'
  result = can_two_movies_fill_flight?([6], 6)
  assert_false(result, desc)

  desc = 'no movies'
  result = can_two_movies_fill_flight?([], 2)
  assert_false(result, desc)
end

def run_tests_set
  desc = 'short flight'
  result = can_two_movies_fill_flight_set?([2, 4], 1)
  assert_false(result, desc)

  desc = 'long flight'
  result = can_two_movies_fill_flight_set?([2, 4], 6)
  assert_true(result, desc)

  desc = 'one movie half flight length'
  result = can_two_movies_fill_flight_set?([3, 8], 6)
  assert_false(result, desc)

  desc = 'two movies half flight length'
  result = can_two_movies_fill_flight_set?([3, 8, 3], 6)
  assert_true(result, desc)

  desc = 'lots of possible pairs'
  result = can_two_movies_fill_flight_set?([1, 2, 3, 4, 5, 6], 7)
  assert_true(result, desc)

  desc = 'not using first movie'
  result = can_two_movies_fill_flight_set?([4, 3, 2], 5)
  assert_true(result, desc)

  desc = 'multiple movies shorter than flight'
  result = can_two_movies_fill_flight_set?([5, 6, 7, 8], 9)
  assert_false(result, desc)

  desc = 'only one movie'
  result = can_two_movies_fill_flight_set?([6], 6)
  assert_false(result, desc)

  desc = 'no movies'
  result = can_two_movies_fill_flight_set?([], 2)
  assert_false(result, desc)
end

def assert_true(value, desc)
  # puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  # puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

# curious is there is a measureable difference between using a hash or a set
# does not appear to be the case since both are using direct access, multiple
# runs are all very close to each other
Benchmark.bmbm do |x|
  x.report("Hash") { run_tests }
  x.report("Set")  { run_tests_set }
end

# Rehearsal ----------------------------------------
# Hash   0.001487   0.000092   0.001579 (  0.001572)
# Set    0.000025   0.000000   0.000025 (  0.000024)
# ------------------------------- total: 0.001604sec

#            user     system      total        real
# Hash   0.000022   0.000000   0.000022 (  0.000019)
# Set    0.000025   0.000000   0.000025 (  0.000022)

Benchmark.memory do |x|
  x.report("Hash") { run_tests }
  x.report("Set")  { run_tests_set }
end

# There does seem to be a difference in space usage though
# Hash     2.104k memsize (     0.000  retained)
#         27.000  objects (     0.000  retained)
#          9.000  strings (     0.000  retained)
# Set      2.464k memsize (     0.000  retained)
#         36.000  objects (     0.000  retained)
#          9.000  strings (     0.000  retained)
