module Batfish

  # A Queue is a first in, first out
  # (FIFO) data structure characterized
  # by two fundamental operations:
  # enqueue and dequeue.
  class Queue
    attr_reader :first, :last

    # Initializes a Queue.
    def initialize()
      @first = nil
      @last = nil
    end
    
    # Returns true if the queue is
    # empty.
    def empty?()
      return @first.nil?
    end
    
    # Adds an object to the back
    # of the queue. Returns the
    # queue itself so several
    # enqueue may be chained.
    def enqueue(obj)
      node = Node.new(obj)
      if @first.nil?
        @first = @last = node
      else
        @last.next = node
        @last = node
      end
      return self
    end
    alias_method :<<, :enqueue
    
    # Removes the object at
    # the front of the queue
    # and returns it.
    def dequeue()
      node = @first
      @first = @first.next 
      return node.value
    end
    
    # Calls block once for each
    # object in the queue, starting
    # with the one at the front.
    def each()
      cur = @first
      while cur
        yield cur.value
        cur = cur.next
      end
    end
    
    # This class represents a node
    # in a queue.
    class Node
      attr_accessor :value, :next, :prev
      
      # Initializes a Queue Node with
      # the given object as its value 
      # or nil if no object is given.
      def initialize(obj=nil)
        @value = obj
        @next = nil
      end
    end
  end
end
