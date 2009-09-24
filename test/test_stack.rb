require 'test/unit'
require 'test/helper'

include Batfish

class TestStack < Test::Unit::TestCase

  def setup
    @s = Stack.new()
  end

  def test_empty?
    assert(@s.empty?)
    @s.push(5)
    @s.push(7)
    @s << 1 << 2
    @s.pop()
    @s.pop()
    @s.pop()
    @s.pop()
    assert(@s.empty?)
  end

  def test_pop
    @s << 1 << 5 << 9
    assert_equal(9, @s.pop)
    assert_equal(5, @s.pop)
    @s << 3 << 4
    assert_equal(4, @s.pop)
    assert_equal(3, @s.pop)
    assert_equal(1, @s.pop)
    assert(@s.empty?)
  end

  def test_each
    elements = [1,5,9,13,8,5]
    elements.each do |el|
      @s << el
    end
    i = elements.length - 1
    @s.each do |el|
      assert_equal(el, elements[i])
      i -= 1
    end
  end
end
