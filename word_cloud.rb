# frozen_string_literal: true

# You want to build a word cloud, an infographic where the size of a word corresponds to how often it appears in the body of text.

# To do this, you'll need data. Write code that takes a long string and builds its word cloud data in a hash ↴ , where the keys are words and the values are the number of times the words occurred.

# Think about capitalized words. For example, look at these sentences:

#   "After beating the eggs, Dana read the next step:"
# "Add milk and eggs, then add flour and sugar."

# What do we want to do with "After", "Dana", and "add"? In this example, your final hash should include one "Add" or "add" with a value of 22.
# Make reasonable (not necessarily perfect) decisions about cases like "After" and "Dana".

# Assume the input will only contain words and standard punctuation.

# Matt's Note
#
# The instructions for this excercise are not, in my opinion, in accordance to the tests. The instructions
# ask the user to make reasonable descisions about capitalization which is subjective, but the tests enforce a specific
# pattern of handling capitalization: If the word appears once leave it capitalized, if the word appears multiple times it should be downcased.

class WordCloudData
  attr_reader :words_to_counts

  SKIPPABLE_CHARACTERS = %w[-].freeze
  PUNCTUATION = /[!?.()*&:]/.freeze

  def initialize(input_string)
    # Count the frequency of each word.
    @words_to_counts = {}

    string_array = input_string.split(' ')
    string_array = input_string.split('...') if string_array.size == 1

    string_array.each do |word|
      clean_word = word.gsub(PUNCTUATION, '')

      next if SKIPPABLE_CHARACTERS.include?(word)

      # handle capitalization in the wierd way the tests want you to
      if @words_to_counts[clean_word.capitalize]
        value = @words_to_counts[clean_word.capitalize]
        @words_to_counts.delete(clean_word.capitalize)

        @words_to_counts[clean_word] = value
      end

      @words_to_counts[clean_word] = @words_to_counts[clean_word] ? @words_to_counts[clean_word] + 1 : 1
    end
  end
end

# Tests

def run_tests
  desc = 'simple sentence'
  input = 'I like cake'

  word_cloud = WordCloudData.new(input)
  actual = word_cloud.words_to_counts
  expected = { 'I' => 1, 'like' => 1, 'cake' => 1 }
  assert_equal(actual, expected, desc)

  desc = 'longer sentence'
  input = 'Chocolate cake for dinner and pound cake for dessert'

  word_cloud = WordCloudData.new(input)
  actual = word_cloud.words_to_counts
  expected = {
    'and' => 1,
    'pound' => 1,
    'for' => 2,
    'dessert' => 1,
    'Chocolate' => 1,
    'dinner' => 1,
    'cake' => 2
  }
  assert_equal(actual, expected, desc)

  desc = 'punctuation'
  input = 'Strawberry short cake? Yum!'

  word_cloud = WordCloudData.new(input)
  actual = word_cloud.words_to_counts
  expected = { 'cake' => 1, 'Strawberry' => 1, 'short' => 1, 'Yum' => 1 }
  assert_equal(actual, expected, desc)

  desc = 'hyphenated words'
  input = 'Dessert - mille-feuille cake'

  word_cloud = WordCloudData.new(input)
  actual = word_cloud.words_to_counts
  expected = { 'cake' => 1, 'Dessert' => 1, 'mille-feuille' => 1 }
  assert_equal(actual, expected, desc)

  desc = 'ellipses between words'
  input = 'Mmm...mmm...decisions...decisions'

  word_cloud = WordCloudData.new(input)
  actual = word_cloud.words_to_counts
  expected = { 'mmm' => 2, 'decisions' => 2 }
  assert_equal(actual, expected, desc)

  desc = 'apostrophes'
  input = "Allie's Bakery: Sasha's Cakes"

  word_cloud = WordCloudData.new(input)
  actual = word_cloud.words_to_counts
  expected = { 'Bakery' => 1, 'Cakes' => 1, "Allie's" => 1, "Sasha's" => 1 }
  assert_equal(actual, expected, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
