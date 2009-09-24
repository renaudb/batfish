module Batfish

  # A BK-tree is a data structure used for
  # nearest neighbor lookup in a metric space.
  # A metric space is any space with the
  # following properties:
  #
  # * d(x,y) = 0 <=> x = y
  # * d(x,y) = d(y,x)
  # * d(x,z) <= d(x,y) + d(y,z)
  #
  # To use this data structure, the objects added
  # to it must have a distance_to(other) class method
  # defined.
  class BKTree
    attr_reader :root
    
    # Initializes a BKTree.
    def initialize()
      @root = nil
    end
    
    # Adds an object to the tree.
    # Returns the tree itself so several
    # adds may be chained together.
    def add(obj)
      if @root
        @root.add(obj)
      else
        @root = Node.new(obj)
      end
      return self
    end
    alias_method :<<, :add

    # Returns true if the tree is empty.
    def empty?()
      return @root.nil? ? true : false
    end
    
    # Returns true if the given object is
    # present in the tree.
    def include?(obj)
      self.include_near?(obj, 0)
    end

    # Return true if the given object is
    # within threshold distance of an
    # object in the tree.
    def include_near?(obj, threshold)
      self.fetch_near(obj, threshold) do
        return true
      end
      return false
    end

    # Returns an array containing all
    # object within threshold distance 
    # of the given object. If a block is 
    # given, it is called once for each 
    # objects within threshold distance
    # of the given object.
    def fetch_near(obj, threshold)
      objs = []
      @root.fetch_near(obj, threshold) do |item|
        yield(item) if block_given? 
        objs << item
      end
      return objs
    end

    # Returns the nearest object to
    # the given object.
    def fetch_nearest(obj)
      threshold = 0
      nearests = []
      while nearests.empty?
        self.fetch_near(obj, threshold) do |item|
          yield(item) if block_given? 
          nearests << item
        end
        threshold += 1
      end
      return nearests
    end

    # Returns the minimum distance
    # between the given object and
    # an object in the tree.
    def min_dist(obj)
      threshold = 0
      while !self.include_near?(obj, threshold)
        threshold += 1
      end
      return threshold
    end
  
    # This class represents a node
    # in a BKTree.
    class Node
      attr_reader :value, :children
      
      # Initializes a BKTree Node with
      # the given object as its value
      # or nil if no object is given.
      def initialize(obj=nil)
        @value = obj
        @children = {}
      end
      
      # Adds a node to a node in
      # a recursive way.
      def add(obj)
        distance = obj.distance_to(@value)
        if child = @children[distance]
          child.add(obj)
        else
          @children[distance] = Node.new(obj)
        end
      end

      # Calls block once for each
      # object within threshold distance
      # of the given object that are
      # part of a child node of self.
      def fetch_near(obj, threshold, &block)
        distance = @value.distance_to(obj)
        if distance <= threshold
          yield @value
        end
        ((distance - threshold)..(distance + threshold)).each do |d|
          if child = @children[d]
            child.fetch_near(obj, threshold, &block)
          end
        end
      end
    end
  end
end
