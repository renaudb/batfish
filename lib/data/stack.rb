module Batfish

  # A Stack is a last in, first out
  # (LIFO) data structure characterized
  # by two fundamental operations:
  # push and pop.
  class Stack
    attr_reader :first
    
    # Initializes a Stack.
    def initialize()
      @first = nil
    end
    
    # Returns true if the stack is
    # empty.
    def empty?()
      return @first.nil?
    end
    
    # Adds an object to the top of
    # the list. Returns the stack
    # itself so several push may be
    # chained.
    def push(obj)
      node = Node.new(obj)
      node.next = @first
      @first = node 
      return self
    end
    alias_method :<<, :push
    
    # Removes the object at the top
    # of the stack and returns it.
    def pop()
      node = @first
      @first = @first.next 
      return node.value
    end
    
    # Calls block once for each object
    # in the stack, starting with the
    # one on the top.
    def each()
      cur = @first
      while cur
        yield cur.value
        cur = cur.next
      end
    end
    
    # This class represents a node in
    # a Stack.
    class Node
      attr_accessor :value, :next, :prev
      
      # Initializes a Stack Node with
      # the given object as its value
      # or nil if no object is given.
      def initialize(obj=nil)
        @value = obj
        @next = nil
      end
    end
  end
end
