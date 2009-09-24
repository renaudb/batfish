module Batfish

  # A Linked List is a data structure 
  # that consists of a sequence of data 
  # records such that each record point 
  # to the following record of the 
  # sequence.
  class LinkedList
    attr_reader :first
    
    # Initializes a Linked List.
    def initialize()
      @first = nil
    end
    
    # Returns true if the linked list
    # is empty.
    def empty?()
      return @first.nil?
    end
    
    # Returns true if the given object
    # is present in the tree.
    def include?(obj)
      self.each do |node| 
        if node == obj
          return true
        end
      end
      return false
    end
    
    # Returns the length of the linked
    # list.
    def length()
      length = 0
      self.each { length += 1 }
      return length
    end

    # Inserts an object at the beginning
    # of the linked list. Returns the
    # linked list itself so several
    # inserts may be chained together.
    def insert_begin(obj)
      node = Node.new(obj)
      node.next, @first = @first, node
      return self
    end
    alias_method :<<, :insert_begin
    
    # Inserts an object after a given
    # object in the linked list.
    # Returns nil if the given object
    # can't be found otherwise returns
    # the linked list itself so several
    # inserts may be chained together.
    def insert_after(obj, after)
      node = Node.new(obj)
      cur = @first
      while cur
        if cur.value == after
          cur.next, node.next = node, cur.next
          return self
        end
        cur = cur.next
      end
      return nil
    end

    # Removes the object at the beginning
    # of the linked list. Returns the
    # removed object.
    def delete_begin()
      node = @first
      @first = @first.next
      return node.value
    end

    # Removes the object after a given
    # object in the linked list. Returns
    # nil if the object can't be found,
    # otherwise returns the removed
    # object.
    def delete_after(after)
      cur = @first
      while cur
        if cur.value == after
          node = cur.next
          cur.next = node.next
          return node
        end
        cur = cur.next
      end
      return nil
    end

    # Removes a given object in the linked
    # list. Returns nil if the object
    # can't be found, otherwise returns
    # the removed object.
    def delete(obj)
      cur = @first
      if cur.value == obj
        @first = @first.next
      end
      while cur.next do
        if cur.next.value == obj
          node = cur.next
          cur.next = node.next
          return node.value
        end
        cur = cur.next
      end
      return nil
    end
    
    # Calls block once for each object
    # in the stack, starting with the
    # object at the beginning.
    def each()
      cur = @first
      while cur do
        yield cur.value
        cur = cur.next
      end
    end
    
    # This class represents a node in
    # a Linked List.
    class Node
      attr_accessor :next
      attr_reader :value
      
      # Initializes a Linked List Node with
      # the given object as its value
      # or nil if no object is given.
      def initialize(obj=nil)
        @value = obj
        @next = nil
      end
    end
  end
  
  # A Sorted Linked List is a data
  # structure that consists of an
  # ordered sequence of data records 
  # such that each record point to 
  # the following record of the sequence.
  class SortedLinkedList < LinkedList
    
    # Inserts an object in the linked list,
    # keeping the objects ordered.
    def insert(obj)
      node = Node.new(obj)
      if @first.nil?
        @first = node
        return self
      end
      prev = nil
      cur = @first
      while cur
        if block_given? 
          if yield(cur.value, obj) >= 0
            break
          end
        elsif obj <= cur.value
          break
        end
        prev = cur
        cur = cur.next
      end
      node.next = cur
      if prev
        prev.next = node
      else
        @first = node
      end
      return self
    end
    alias_method :<<, :insert
  end
end
