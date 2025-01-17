# Each round, players receive a score between 0 and 100, which you use to rank them from highest to lowest. So far you're using an algorithm that sorts in O(nlg⁡n)O(nlgn) time, but players are complaining that their rankings aren't updated fast enough. You need a faster sorting algorithm.

# Write a method that takes:

#     an array of unsorted_scores
#     the highest_possible_score in the game

# and returns a sorted array of scores in less than O(nlg⁡n)O(nlgn) time.

# For example:

#   unsorted_scores = [37, 89, 41, 65, 91, 53]
# HIGHEST_POSSIBLE_SCORE = 100

# sort_scores(unsorted_scores, HIGHEST_POSSIBLE_SCORE)
# # Returns [91, 89, 65, 53, 41, 37]

# We’re defining n as the number of unsorted_scores because we’re expecting the number of players to keep climbing.

# And, we'll treat highest_possible_score as a constant instead of factoring it into our big O time and space costs because the highest possible score isn’t going to change. Even if we do redesign the game a little, the scores will stay around the same order of magnitude

# This is an example of a counting sort

def sort_scores(unsorted_scores, highest_possible_score)

  # Sort the scores in O(n) time.  
  score_counts = []
  sorted_scores = []

  unsorted_scores.each do |score|
    score_counts[score] = score_counts[score].to_i + 1
  end

  score_counts.each_with_index do |count, score|
    score&.times { sorted_scores.unshift(score) }
  end
  
  sorted_scores
end

# Tests

def run_tests
  desc = 'no scores'
  actual = sort_scores([], 100)
  expected = []
  assert_equal(actual, expected, desc)

  desc = 'one score'
  actual = sort_scores([55], 100)
  expected = [55]
  assert_equal(actual, expected, desc)

  desc = 'two scores'
  actual = sort_scores([30, 60], 100)
  expected = [60, 30]
  assert_equal(actual, expected, desc)

  desc = 'many scores'
  actual = sort_scores([37, 89, 41, 65, 91, 53], 100)
  expected = [91, 89, 65, 53, 41, 37]
  assert_equal(actual, expected, desc)

  desc = 'repeated scores'
  actual = sort_scores([20, 10, 30, 30, 10, 20], 100)
  expected = [30, 30, 20, 20, 10, 10]
  assert_equal(actual, expected, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
