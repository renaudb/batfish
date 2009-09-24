require 'test/unit'
require 'test/helper'

include Batfish

class TestLinkedList < Test::Unit::TestCase
  
  def setup
    @ll = LinkedList.new()
  end
  
  def test_empty?
    assert(@ll.empty?)
    @ll.insert_begin(1)
    @ll.insert_begin(2)
    @ll << 3 << 4 << 5
    @ll.delete_begin()
    @ll.delete_begin()
    @ll.delete_begin()
    @ll.delete_begin()
    @ll.delete_begin()
    assert(@ll.empty?)
  end

  def test_insert
    @ll.insert_begin(5)
    @ll.insert_begin(3)
    @ll.insert_begin(1)
    @ll.insert_after(2, 1)
    @ll.insert_after(4, 3)
    cur = @ll.first
    i = 1
    while cur
      assert_equal(i, cur.value)
      i += 1
      cur = cur.next
    end
  end

  def test_delete
    @ll << 9 << 8 << 7 << 6 << 5 << 4 << 3 << 2 << 1
    @ll.delete(8)
    @ll.delete(5)
    @ll.delete(2)
    assert(!@ll.delete(99))
    @ll.delete_begin
    @ll.delete_begin
    @ll.delete_after(7)
    @ll.delete_after(4)
    elements = [4,7]
    cur = @ll.first
    elements.each do |el|
      assert_equal(el, cur.value)
      cur = cur.next
    end
  end

  def test_include?
    @ll << 1
    assert(@ll.include?(1))
    @ll.delete(1)
    assert(!@ll.include?(1))
    @ll << 1
    assert(@ll.include?(1))
  end

  def test_length
    @ll << 1 << 2 << 3 << 4 << 5
    assert_equal(5, @ll.length)
    @ll.delete_begin()
    @ll.delete_begin()
    assert_equal(3, @ll.length)
    @ll << 6
    assert_equal(4, @ll.length)
  end

  def test_each
    elements = [1,2,3,4,5]
    elements.each do |el|
      @ll << el
    end
    i = elements.length
    @ll.each do |el|
      assert_equal(i, el)
      i -= 1
    end
  end
end

class TestSortedLinkedList < Test::Unit::TestCase

  def setup
    @sll = SortedLinkedList.new()
  end

  def test_insert
    elements = [5,1,3,4,2,6]
    elements.each do |el|
      @sll << el
    end
    i = 1
    @sll.each do |el|
      assert_equal(i, el)
      i += 1
    end
  end
  
  def test_insert_block
    elements = [5,1,3,4,2,6]
    elements.each do |el|
      @sll.insert(el) { |x,y| -x <=> -y }
    end
    i = elements.length
    @sll.each do |el|
      assert_equal(i, el)
      i -= 1
    end
  end
end
