# Wrapper class to hold state.
class Fibbo
  def initialize
    @memo = {}
  end

  def fib(n)
    raise "Error" if n < 0

    # iterative_fib(n)
    recursive_fib(n)
  end

  def iterative_fib(n)
    return n if n <= 1

    a, b = 0, 1

    (1..n).each do
      # a, b = b, a + b
      temp = b
      b = a + b
      a = temp
    end

    a
  end

  def recursive_fib(n)
    puts "Stack size #{caller.inspect.size}"
    if n <= 1
      n
    elsif @memo.key? n
      # puts "Fetching F(#{n})"
  
      @memo[n]
    else
      # puts "Calculating F(#{n})"
      
      @memo[n] = recursive_fib(n - 1) + recursive_fib(n - 2)
    end
  end
end



















# Tests

def run_tests
  my_fib = Fibbo.new

  desc = 'zeroth fibonacci'
  actual = my_fib.fib(0)
  expected = 0
  assert_equal(actual, expected, desc)

  desc = 'first fibonacci'
  actual = my_fib.fib(1)
  expected = 1
  assert_equal(actual, expected, desc)

  desc = 'second fibonacci'
  actual = my_fib.fib(2)
  expected = 1
  assert_equal(actual, expected, desc)

  desc = 'third fibonacci'
  actual = my_fib.fib(3)
  expected = 2
  assert_equal(actual, expected, desc)

  desc = 'fifth fibonacci'
  actual = my_fib.fib(5)
  expected = 5
  assert_equal(actual, expected, desc)

  desc = 'tenth fibonacci'
  actual = my_fib.fib(10)
  expected = 55
  assert_equal(actual, expected, desc)

  desc = 'negative fibonacci'
  assert_raises(desc) { my_fib.fib(-1) }
end

def assert_equal(a, b, desc)
  puts "#{desc} ... #{a == b ? 'PASS' : "FAIL: #{a.inspect} != #{b.inspect}"}"
end

def assert_raises(desc)
  yield
  puts "#{desc} ... FAIL"
rescue
  puts "#{desc} ... PASS"
end

run_tests
