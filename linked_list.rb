class LinkedListNode
  attr_accessor :value, :next

  def initialize(value, next_node = nil)
    @value = value
    @next = next_node
  end

  def values
    vs = []

    node = self
    while node
      vs << node.value
      node = node.next
    end

    vs
  end
end
