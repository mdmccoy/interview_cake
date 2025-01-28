require 'set'
require 'byebug'

def build_path(how_we_got_to, end_node)
  previous_node = how_we_got_to[end_node]
  path = [end_node]
  
  while previous_node
    path.push previous_node
    p previous_node

    previous_node = how_we_got_to[previous_node]
  end
  
  path.reverse
end

# def get_path(graph, start_node, end_node)
#   # Find the shortest route in the network between the two users.
#   # Shortest path from one node to another in an undirected/unweighted graph can be found by using BFS
#   # to go from one node and then backtracking when you reach the second.
  
#   # raise an error if we're missing any inputs
  
  
#   # if they are adjacent
#   # return [start_node, end_node] if graph[start_node].include?(end_node)

#   # if they are the same
#   return [start_node] if start_node == end_node

#   # if we have someone in common with the end node then we dont need to check anything
#   # mutual_neighbors = graph[start_node] & graph[end_node]
#   # return [start_node, mutual_neighbors.first, end_node] unless mutual_neighbors.empty?
  
#   bfs_get_path(graph, start_node, end_node)
# end



def get_path(graph, start_node, end_node)
  raise 'error' unless graph[start_node] && graph[end_node]

  queue = Queue.new
  queue.push start_node
  how_we_got_to = { start_node => nil }
  
  while queue.size.positive?
    node = queue.shift

    if node == end_node
      # return our path
      return build_path how_we_got_to, end_node
    end

    graph[node].each do |n|
      next if how_we_got_to.has_key? n

      queue.push n
      how_we_got_to[n] = node
    end
  end

  nil
end



# Tests

def run_tests
  @graph = {
    a: [:b, :c, :d],
    b: [:a, :d],
    c: [:a, :e],
    d: [:a, :b],
    e: [:c],
    f: [:g],
    g: [:f],
  }

  desc = 'two hop path 1'
  actual = get_path(@graph, :a, :e)
  expected = [:a, :c, :e]
  assert_equal(actual, expected, desc)

  desc = 'two hop path 2'
  actual = get_path(@graph, :d, :c)
  expected = [:d, :a, :c]
  assert_equal(actual, expected, desc)

  desc = 'one hop path 1'
  actual = get_path(@graph, :a, :c)
  expected = [:a, :c]
  assert_equal(actual, expected, desc)

  desc = 'one hop path 2'
  actual = get_path(@graph, :f, :g)
  expected = [:f, :g]
  assert_equal(actual, expected, desc)

  desc = 'one hop path 3'
  actual = get_path(@graph, :g, :f)
  expected = [:g, :f]
  assert_equal(actual, expected, desc)

  desc = 'zero hop path'
  actual = get_path(@graph, :a, :a)
  expected = [:a]
  assert_equal(actual, expected, desc)

  desc = 'no path'
  actual = get_path(@graph, :a, :f)
  expected = nil
  assert_equal(actual, expected, desc)

  desc = 'start node not present'
  assert_raises(desc) { get_path(@graph, :h, :a) }

  desc = 'end node not present'
  assert_raises(desc) { get_path(@graph, :a, :h) }
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
