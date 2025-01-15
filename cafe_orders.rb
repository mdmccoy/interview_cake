require 'benchmark'
require 'benchmark/memory'

# My cake shop is so popular, I'm adding some tables and hiring wait staff so folks can have a cute sit-down cake-eating experience.

# I have two registers: one for take-out orders, and the other for the other folks eating inside the cafe. All the customer orders get combined into one list for the kitchen, where they should be handled first-come, first-served.

# Recently, some customers have been complaining that people who placed orders after them are getting their food first. Yikes—that's not good for business!

# To investigate their claims, one afternoon I sat behind the registers with my laptop and recorded:

#     The take-out orders as they were entered into the system and given to the kitchen. (take_out_orders)
#     The dine-in orders as they were entered into the system and given to the kitchen. (dine_in_orders)
#     Each customer order (from either register) as it was finished by the kitchen. (served_orders)

# Given all three arrays, write a method to check that my service is first-come, first-served. All food should come out in the same order customers requested it.

# We'll represent each customer order as a unique integer.

# As an example,

#   Take Out Orders: [1, 3, 5]
#  Dine In Orders: [2, 4, 6]
#   Served Orders: [1, 2, 4, 6, 5, 3]

# would not be first-come, first-served, since order 3 was requested before order 5 but order 5 was served first.

# But,

#   Take Out Orders: [17, 8, 24]
#  Dine In Orders: [12, 19, 2]
#   Served Orders: [17, 8, 12, 19, 24, 2]

# would be first-come, first-served.
# 
def first_come_first_served?(take_out_orders, dine_in_orders, served_orders)
  # This solution is O(n) time and O(n) space as we create two copies of served_orders and then subtract our orders from them.
  # Subtracting two arrays iterates through 

  return false if take_out_orders.size + dine_in_orders.size != served_orders.size

  dine_in_in_order = (served_orders - take_out_orders) == dine_in_orders
  take_out_in_order = (served_orders - dine_in_orders) == take_out_orders

  dine_in_in_order && take_out_in_order
end

# Based on my tests, this would be O(1) size because it does not allocate any additional memory
# def first_come_first_served?(take_out_orders, dine_in_orders, served_orders)
#   return false if take_out_orders.size + dine_in_orders.size != served_orders.size

#   # Go through served_orders, checking each served_order is the next order in either array.
#   served_orders.each do |order|
#     if dine_in_orders.first == order
#       dine_in_orders.shift
#     elsif take_out_orders.first == order
#       take_out_orders.shift
#     else
#       return false
#     end
#   end
# end

# Interview Cake solution for testing
def first_come_first_served?(take_out_orders, dine_in_orders, served_orders)
  take_out_orders_index = 0
  dine_in_orders_index = 0
  take_out_orders_max_index = take_out_orders.length - 1
  dine_in_orders_max_index = dine_in_orders.length - 1

  served_orders.each do |order|

    # if we still have orders in take_out_orders
    # and the current order in take_out_orders is the same
    # as the current order in served_orders
    if take_out_orders_index <= take_out_orders_max_index &&
       order == take_out_orders[take_out_orders_index]
      take_out_orders_index += 1

    # if we still have orders in dine_in_orders
    # and the current order in dine_in_orders is the same
    # as the current order in served_orders
    elsif dine_in_orders_index <= dine_in_orders_max_index &&
          order == dine_in_orders[dine_in_orders_index]
      dine_in_orders_index += 1

    # if the current order in served_orders doesn't match the current
    # order in take_out_orders or dine_in_orders, then we're not serving first-come,
    # first-served.
    else
      return false
    end
  end

  # check for any extra orders at the end of take_out_orders or dine_in_orders
  if dine_in_orders_index != dine_in_orders.length ||
     take_out_orders_index != take_out_orders.length
    return false
  end

  # all orders in served_orders have been "accounted for"
  # so we're serving first-come, first-served!
  true
end

def run_tests
  # desc = 'both registers have same number of orders'
  
  Benchmark.memory do |x|
    x.report("1") { first_come_first_served?([1, 4, 5], [2, 3, 6], [1, 2, 3, 4, 5, 6]) }
    x.report("2") { first_come_first_served?([1, 5], [2, 3, 6], [1, 2, 6, 3, 5]) }
    x.report("3") { first_come_first_served?([], [2, 3, 6], [2, 3, 6]) }
    x.report("4") { first_come_first_served?([1, 5], [2, 3, 6], [1, 6, 3, 5]) }
    x.report("5") { first_come_first_served?([1, 5], [2, 3, 6], [1, 2, 3, 5, 6, 8]) }
    x.report("6") { first_come_first_served?([1, 3,5,7,9,11,13,15,17,19], [2, 4, 6,8,10,12,14,16,18,20], (1..20).to_a) }
    a = (1..100).to_a.select {|int| int.even? }
    b = (1..100).to_a.select {|int| int.odd? }
    c = (1..100).to_a
    x.report("7") { first_come_first_served?(a, b, c)}
  end
  # result = first_come_first_served?([1, 4, 5], [2, 3, 6], [1, 2, 3, 4, 5, 6])
  # # assert_true(result, desc)

  # desc = 'registers have different lengths'
  # result = first_come_first_served?([1, 5], [2, 3, 6], [1, 2, 6, 3, 5])
  # assert_false(result, desc)

  # desc = 'one register is empty'
  # result = first_come_first_served?([], [2, 3, 6], [2, 3, 6])
  # assert_true(result, desc)

  # desc = 'served orders is missing orders'
  # result = first_come_first_served?([1, 5], [2, 3, 6], [1, 6, 3, 5])
  # assert_false(result, desc)

  # desc = 'served orders has extra orders'
  # result = first_come_first_served?([1, 5], [2, 3, 6], [1, 2, 3, 5, 6, 8])
  # assert_false(result, desc)

  # desc = 'one register has extra orders';
  # result = first_come_first_served?([1, 9], [7, 8], [1, 7, 8]);
  # assert_false(result, desc)

  # desc = 'one register has unserved orders';
  # result = first_come_first_served?([55, 9], [7, 8], [1, 7, 8, 9]);
  # assert_false(result, desc)

  # desc = 'order numbers are not sequential'
  # result = first_come_first_served?([27, 12, 18], [55, 31, 8], [55, 31, 8, 27, 12, 18])
  # assert_true(result, desc)

end

def assert_true(value, desc)
  puts "#{desc} ... #{value ? 'PASS' : "FAIL: #{value} is not true"}"
end

def assert_false(value, desc)
  puts "#{desc} ... #{value ? "FAIL: #{value} is not false" : 'PASS'}"
end

run_tests
