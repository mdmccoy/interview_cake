require 'set'

class GraphNode
  attr_accessor :label, :neighbors, :color

  def initialize(label)
    @label = label
    @neighbors = Set.new
    @color = nil
  end

  def neighbor_colors
    @neighbors.map {|n| n.color }
  end

  def legal_colors(colors)
    colors - neighbor_colors
  end
end

# BFS in an undirected graph context would visit a node, add all of its neighbors to the queue, then visit the first node in the queue
# Add all its neighbors to the end of the the queue, then visit the next node in the queue, add all its neighbors, etc.
# 
# DFS in an undirected graph context would visit a node, push its neighbors to the the top of the stack, then pop the last/top item from the
# stack, push all its neighbors to the stack. Thus everytime you pop from the stack, you will visit all niehgbors added before
# you get back to another neighbor of the original node (unless you are cyclical)
# 
# legal graph coloring means no two adjacent nodes are the same color

# Sub problems
# As a node, do I have any colored neighbors? If so, those colors are not legal for me.
# Where do you start coloring? The node with the highest degree (D) would have the most rigid colring requirements (D+1). Itself and all of its neighbors must be different
# Find the node with the highest degree using BFS or DFS?
# What if there are multiple nodes of D+1? Just pick one?

# Turns out all we needed to do was visit each node and assign it a color based on the colors of its neighbors.
# Array subtraction allowed us to be efficient in our use of

# Given an array of nodes and a label, return the node with the match label
def node_from_label(nodes, label)
  nodes.each do |n|
    return n if n.label == label
  end
end

def color_graph(graph, colors)

  # Create a valid coloring for the graph.
  
  # Write BFS to create a graph map and find the node with the most edges.
  # We can probably be coloring nodes while we do our BFS?
  graph_hash = {}
  queue = [graph.first]


  # while queue.size > 0
  graph.each do |node|
    raise "loop graph" if node.neighbors.include?(node)

    # Get our node from front of queue
    # node = queue.shift

    # # Add our node and its neighbors to our adjacency hash
    # graph_hash[node.label] = node.neighbors.map(&:label)

    # Color our node?
    node.color = node.legal_colors(colors).first

    # Add all of the neighbors to the queue
    # Unless we've already visited that neighbor.
    # node.neighbors.each do |n|
    #   next if graph_hash[n.label]

    #   queue.push(n)
    # end
  end

  p graph.map {|m| [m.label, m.color] }
end

# Tests

def run_tests
  colors = %w[red green blue orange yellow white]

  desc = 'line graph'
  node_a = GraphNode.new('a')
  node_b = GraphNode.new('b')
  node_c = GraphNode.new('c')
  node_d = GraphNode.new('d')

  node_a.neighbors << node_b
  node_b.neighbors << node_a
  node_b.neighbors << node_c
  node_c.neighbors << node_b
  node_c.neighbors << node_d
  node_d.neighbors << node_c

  graph = [node_a, node_b, node_c, node_d]
  tampered_colors = colors.dup
  color_graph(graph, tampered_colors)
  assert_graph_coloring(graph, colors)

  desc = 'separate graph'
  node_a = GraphNode.new('a')
  node_b = GraphNode.new('b')
  node_c = GraphNode.new('c')
  node_d = GraphNode.new('d')

  node_a.neighbors << node_b
  node_b.neighbors << node_a
  node_c.neighbors << node_d
  node_d.neighbors << node_c

  graph = [node_a, node_b, node_c, node_d]
  tampered_colors = colors.dup
  color_graph(graph, tampered_colors)
  assert_graph_coloring(graph, colors)

  desc = 'triangle graph'
  node_a = GraphNode.new('a')
  node_b = GraphNode.new('b')
  node_c = GraphNode.new('c')

  node_a.neighbors << node_b
  node_a.neighbors << node_c
  node_b.neighbors << node_a
  node_b.neighbors << node_c
  node_c.neighbors << node_a
  node_c.neighbors << node_b

  graph = [node_a, node_b, node_c]
  tampered_colors = colors.dup
  color_graph(graph, tampered_colors)
  assert_graph_coloring(graph, colors)

  desc = 'envelope graph'
  node_a = GraphNode.new('a')
  node_b = GraphNode.new('b')
  node_c = GraphNode.new('c')
  node_d = GraphNode.new('d')
  node_e = GraphNode.new('e')

  node_a.neighbors << node_b
  node_a.neighbors << node_c
  node_b.neighbors << node_a
  node_b.neighbors << node_c
  node_b.neighbors << node_d
  node_b.neighbors << node_e
  node_c.neighbors << node_a
  node_c.neighbors << node_b
  node_c.neighbors << node_d
  node_c.neighbors << node_e
  node_d.neighbors << node_b
  node_d.neighbors << node_c
  node_d.neighbors << node_e
  node_e.neighbors << node_b
  node_e.neighbors << node_c
  node_e.neighbors << node_d

  graph = [node_a, node_b, node_c, node_d, node_e]
  tampered_colors = colors.dup
  color_graph(graph, tampered_colors)
  assert_graph_coloring(graph, colors)

  desc = 'loop graph'
  node_a = GraphNode.new('a')

  node_a.neighbors << node_a

  graph = [node_a]
  tampered_colors = colors.dup
  assert_raises(desc) { color_graph(graph, tampered_colors) }
end

def assert_graph_coloring(graph, colors)
  assert_graph_has_colors(graph, colors)
  assert_graph_color_limit(graph)
  graph.each(&method(:assert_node_unique_color))
end

def assert_graph_has_colors(graph, colors)
  graph.each do |node|
    msg = "Node #{node.label} color"
    assert_in(node.color, colors, msg)
  end
end

def assert_graph_color_limit(graph)
  max_degree, colors_found =
    graph.reduce([0, Set.new]) do |(current_degree, colors), node|
      [[node.neighbors.size, current_degree].max, colors + [node.color]]
    end
  max_colors = max_degree + 1
  used_colors = colors_found.size
  msg = "Used #{used_colors} colors and expected #{max_colors} at most"
  assert_less_equal(used_colors, max_colors, msg)
end

def assert_node_unique_color(node)
  node.neighbors.each do |neighbor|
    msg = "Adjacent nodes #{node.label} and #{neighbor.label} have the same color #{node.color}"
    assert_not_equal(node.color, neighbor.color, msg)
  end
end

def assert_in(a, bs, desc)
  puts "#{desc} ... #{bs.include?(a) ? 'PASS' : "FAIL: #{a.inspect} not in #{bs.inspect}"}"
end

def assert_less_equal(a, b, desc)
  puts "#{desc} ... #{a <= b ? 'PASS' : 'FAIL'}"
end

def assert_not_equal(a, b, desc)
  puts "#{desc} ... #{a != b ? 'PASS' : 'FAIL'}"
end

def assert_raises(desc)
  yield
  puts "#{desc} ... FAIL"
rescue
  puts "#{desc} ... PASS"
end

run_tests
