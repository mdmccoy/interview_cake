
<<-DESC
Your quirky boss collects rare, old coins...

They found out you're a programmer and asked you to solve something they've been wondering for a long time.

Write a method that, given:

    an amount of money
    an array of coin denominations

computes the number of ways to make the amount of money with coins of the available denominations.

Example: for amount=44 (44¢) and denominations=[1,2,3][1,2,3] (11¢, 22¢ and 33¢), your program would output 44—the number of ways to make 44¢ with those denominations:

    1¢, 1¢, 1¢, 1¢
    1¢, 1¢, 2¢
    1¢, 3¢
    2¢, 2¢
DESC

def change_possibilities_a(amount, denominations)
  a = Changer.new
  answer = a.top_down(amount, denominations)

  puts a.known_permutations

  answer

  # Calculate the number of ways to make change.
end


class Changer
  attr_accessor :known_permutations

  def initialize
    @known_permutations = {}
  end

  def change_possibilities(amount, denominations)
    top_down(amount, denominations)
  
    # Calculate the number of ways to make change.
  end


  def top_down(amount_left, denominations, current_index = 0)


    memo_key = [amount_left, current_index].to_s
    if @known_permutations.include? memo_key
      puts "grabbing known permutation#{memo_key}"
      return @known_permutations[memo_key]
    end
    
    # Base cases
    return 1 if amount_left.zero?

    # We overshot
    return 0 if amount_left.negative?

    # We are all the way through our coins
    return 0 if current_index == denominations.size

    puts "checking ways to make #{amount_left} with #{denominations[current_index..-1]}"

    current_coin = denominations[current_index]

    num_possibilities = 0

    while amount_left >= 0      
      # puts "calculating #{amount_left} using #{denominations[current_index..-1]}"
      num_possibilities += top_down(amount_left, denominations, current_index + 1)

      
      amount_left -= current_coin
      puts "current_coin: #{current_coin} amount_left: #{amount_left}"
    end

    @known_permutations[memo_key] = num_possibilities

    num_possibilities
  end

end

require 'byebug'

def change_possibilities(amount = 5, denominations = [1])
  # Build an array where the index is the amount, and the value are the number of ways to make that amount
  # with our denominations

  ways_of_doing_n_cents = [1] + Array.new(amount, 0)

  denominations.each do |coin|
    # calculate the ways to make that amount with that coin

    p ways_of_doing_n_cents
    
    (coin..amount).each do |higher_amount|
      higher_amount_remainder = higher_amount - coin
      p "Coin: #{coin}, higher_amount_remainer: #{higher_amount_remainder}"
      ways_of_doing_n_cents[higher_amount] += ways_of_doing_n_cents[higher_amount_remainder]
    end

  end

  ways_of_doing_n_cents[amount]
end

# def number_of_uses(amount, denominations)
#   byebug
#   answer = 0
#   denominations.each do |denomination|
#     number_of_uses_without_exceding(amount, denomination).times do
#       answer += number_of_uses(amount, denominations - [denomination])
#     end
#   end

#   p answer
# end

# def remaining_amount(amount, denominations)
#   amount - denominations.sum
# end

# def number_of_uses_without_exceding(amount, denomination)
#   amount / denomination
# end









# Tests

def run_tests
  actual = change_possibilities(4, [1, 2, 3])
  expected = 4
  assert_equal(actual, expected, 'sample input')

  # actual = change_possibilities(0, [1, 2])
  # expected = 1
  # assert_equal(actual, expected, 'one way to make zero cents')

  # actual = change_possibilities(1, [])
  # expected = 0
  # assert_equal(actual, expected, 'no ways if no coins')

  # actual = change_possibilities(5, [25, 50])
  # expected = 0
  # assert_equal(actual, expected, 'big coin value')

  # actual = change_possibilities(50, [5, 10])
  # expected = 6
  # assert_equal(actual, expected, 'big target amount')

  # actual = change_possibilities(100, [1, 5, 10, 25, 50])
  # expected = 292
  # assert_equal(actual, expected, 'change for one dollar')
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
