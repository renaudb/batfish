module Batfish

  # A Trie is a data structure used to
  # store key value pairs where the key
  # is a string. It does so by through
  # a tree-like structure where each edge
  # as a character associated to it.
  # To walk through the trie, you go down
  # one character of the key at a time
  # until you reach the end of the key.
  class Trie
    attr_reader :root
    
    # Initializes a Trie.
    def initialize()
      @root = Node.new()
    end
    
    # Adds a key value pair to
    # the trie. Returns the trie
    # itself so calls to add may be
    # chained together.
    def add(key, value)
      @root.add(key.to_s.upcase.split(""), value)
      return self
    end
    alias_method :[]=, :add

    # Deletes the given key value pair
    # from the trie. Returns the trie
    # itself so several delete may
    # be chained.
    def delete(key)
      @root.delete(key.to_s.upcase.split(""))
      return self
    end
    
    # Returns the value associated with
    # the given key. Returns nil if it
    # is not found.
    def fetch(key)
      @root.fetch(key.upcase.split(""))
    end
    alias_method :[], :fetch
    
    # Returns true if the trie contains
    # the given key.
    def has_key?(key)
      return self.fetch(key) ? true : false
    end
    
    # Returns true if the trie contains
    # the given value.
    def has_value?(value)
      self.each do |k, v|
        return true if v == value
      end
      return false
    end

    # Returns true if the trie is empty.
    def empty?()
      return @root.children.empty? ? true : false
    end
    
    # Calls block once for each key value
    # pair in the trie.
    def each()
      @root.each("") do |k, v|
        yield(k, v)
      end
    end
    
    # This class represents a node in
    # a Trie.
    class Node
      attr_reader :value, :children
      
      # Initializes a Trie Node with
      # the given object as its value
      # or nil if no object is given.
      def initialize(value=nil)
        @value = value
        @children = {}
      end
      
      # Adds a node to a node in a
      # recursive way.
      def add(key, value)
        if key.empty?
          @value = value
        else
          letter = key.shift
          if !@children[letter]
            @children[letter] = Node.new()
          end
          @children[letter].add(key, value)
        end
      end

      # Deletes a key value pair from 
      # a node in a recursive way.
      def delete(key)
        if key.empty?
          if !@value.nil? and @children.empty?
            @value = nil
            return true
          else
            @value = nil
            return false
          end
        end
        letter = key.shift
        if @children[letter].delete(key)
          @children.delete(letter)
          if @children.empty?
            return true
          end
        end
        return false
      end
      
      # Returns the value associated
      # with key. Returns nil if it
      # is not found.
      def fetch(key)
        if key.empty?
          return @value
        end
        child = @children[key.shift]
        if child
          child.fetch(key)
        else
          return nil
        end
      end
      
      # Calls block once for each key
      # value pairs under self.
      def each(key, &block)
        if @value
          yield(key, @value)
        end
        @children.each do |letter, child|
          child.each(key + letter, &block)
        end
      end
    end
  end
end

