require 'test/unit'
require 'test/helper'

include Batfish

class TestQueue < Test::Unit::TestCase

  def setup
    @q = Queue.new()
  end

  def test_empty?
    assert(@q.empty?)
    @q.enqueue(1)
    @q.enqueue(2)
    @q << 3 << 4
    @q.dequeue()
    @q.dequeue()
    @q.dequeue()
    @q.dequeue()
    assert(@q.empty?)
  end

  def test_dequeue
    @q << 1 << 2 << 3
    assert_equal(1, @q.dequeue())
    assert_equal(2, @q.dequeue())
    @q << 4 << 5
    assert_equal(3, @q.dequeue())
    assert_equal(4, @q.dequeue())
    assert_equal(5, @q.dequeue())
    assert(@q.empty?)
  end

  def test_each
    elements = [1,2,3,4,5,6]
    elements.each do |el|
      @q << el
    end
    i = 0
    @q.each do |el|
      assert_equal(elements[i], el)
      i += 1
    end
  end
end
