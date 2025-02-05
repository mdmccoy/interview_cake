<<-DESC
  
You are a renowned thief who has recently switched from stealing precious metals to stealing cakes because of the insane profit margins. You end up hitting the jackpot, breaking into the world's largest privately owned stock of cakes—the vault of the Queen of England.

While Queen Elizabeth has a limited number of types of cake, she has an unlimited supply of each type.

Each type of cake has a weight and a value, stored in an array with two indices:

An integer representing the weight of the cake in kilograms
An integer representing the monetary value of the cake in British shillings
For example:

  # Weighs 7 kilograms and has a value of 160 shillings.
[7, 160]

# Weighs 3 kilograms and has a value of 90 shillings.
[3, 90]

Ruby
You brought a duffel bag that can hold limited weight, and you want to make off with the most valuable haul possible.

Write a method max_duffel_bag_value() that takes an array of cake type arrays and a weight capacity, and returns the maximum monetary value the duffel bag can hold.

For example:

  cake_arrays = [[7, 160], [3, 90], [2, 15]]
capacity = 20

max_duffel_bag_value(cake_arrays, capacity)
# => 555
# (6 of the middle type of cake and 1 of the last type of cake)

Ruby
Weights and values may be any non-negative integer. Yes, it's weird to think about cakes that weigh nothing or duffel bags that can't hold anything. But we're not just super mastermind criminals—we're also meticulous about keeping our algorithms flexible and comprehensive.
DESC


def max_duffel_bag_value(cake_tuples, weight_capacity)
  max_values_at_capacities = Array.new(weight_capacity + 1, 0)

  (0..weight_capacity).each do |current_capacity|

    current_max_value = 0

    cake_tuples.each do |cake_weight, cake_value|

      if cake_weight <= current_capacity

        max_value_using_cake = cake_value + max_values_at_capacities[current_capacity - cake_weight]

        current_max_value = [current_max_value, max_value_using_cake].max
      end

      max_values_at_capacities[current_capacity] = current_max_value
    end
  end

  p weight_capacity
  p cake_tuples
  p max_values_at_capacities

  if max_values_at_capacities.first > 0
    Float::INFINITY
  else
    max_values_at_capacities.last
  end
end

def max_duffel_bag_value_with_capacity_1(cake_arrays)

  max_value_at_capacity_1 = 0

  cake_arrays.each do |cake_weight, cake_value|
    if cake_weight == 1
      max_value_at_capacity_1 = [max_value_at_capacity_1, cake_value].max
    end
  end

  max_value_at_capacity_1
end

def max_duffel_bag_value_with_capacity_2(cake_arrays)
  max_value_at_capacity_2 = 0
  cake_arrays.each do |cake_weight, cake_value|
    if cake_weight == 2
      max_value_at_capacity_2 == [max_value_at_capacity_2, cake_value].max
    end

    if cake_weight == 1
      max_value_at_capacity_2 == [2 * max_value_at_capacity_1(cake_arrays), max_value_at_capacity_2].max
    end
  end
end

# Tests

def run_tests
  desc = 'one cake'
  actual = max_duffel_bag_value([[2, 1]], 9)
  expected = 4
  assert_equal(actual, expected, desc)

  desc = 'two cakes'
  actual = max_duffel_bag_value([[4, 4], [5, 5]], 9)
  expected = 9
  assert_equal(actual, expected, desc)

  desc = 'only take less valuable cake'
  actual = max_duffel_bag_value([[4, 4], [5, 5]], 12)
  expected = 12
  assert_equal(actual, expected, desc)

  desc = 'lots of cakes'
  actual = max_duffel_bag_value([[2, 3], [3, 6], [5, 1], [6, 1], [7, 1], [8, 1]], 7)
  expected = 12
  assert_equal(actual, expected, desc)

  desc = 'value to weight ratio is not optimal'
  actual = max_duffel_bag_value([[51, 52], [50, 50]], 100)
  expected = 100
  assert_equal(actual, expected, desc)

  desc = 'zero capacity'
  actual = max_duffel_bag_value([[1, 2]], 0)
  expected = 0
  assert_equal(actual, expected, desc)

  desc = 'cake with zero value and weight'
  actual = max_duffel_bag_value([[0, 0], [2, 1]], 7)
  expected = 3
  assert_equal(actual, expected, desc)

  desc = 'cake with non zero value and zero weight'
  actual = max_duffel_bag_value([[0, 5]], 5)
  expected = Float::INFINITY
  assert_equal(actual, expected, desc)
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

run_tests
