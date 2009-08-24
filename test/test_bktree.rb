require 'test/unit'
require 'test/helper'

include Batfish

class Numeric
  def distance_to(other)
    return (self - other).abs
  end
end

class TestBKTree < Test::Unit::TestCase

  def setup
    @t = BKTree.new()
  end

  def test_empty?
    assert(@t.empty?)
  end

  def test_include?
    @t.add(1)
    @t.add(4)
    @t.add(5)
    @t.add(9)
    @t.add(12)
    assert(@t.include?(5))
    assert(!@t.include?(6))
  end

  def test_include_near?
    @t.add(1)
    @t.add(4)
    @t.add(5)
    @t.add(9)
    @t.add(12)
    assert(@t.include_near?(11, 1))
    assert(!@t.include_near?(20, 5))
  end

  def test_fetch_near
    @t.add(1)
    @t.add(4)
    @t.add(5)
    @t.add(9)
    @t.add(12)
    assert_equal([1,4,5,9,12], @t.fetch_near(0, 20).sort)
    assert_equal([1,4,5], @t.fetch_near(0, 5).sort)
    result = []
    @t.fetch_near(0, 5) do |v|
      result << v
    end
    assert_equal([1,4,5], result.sort)
  end
    
  def test_min_dist
    @t.add(1)
    @t.add(4)
    @t.add(5)
    @t.add(9)
    @t.add(12)
    assert_equal(0, @t.min_dist(4))
    assert_equal(0, @t.min_dist(12))
    assert_equal(8, @t.min_dist(20))
    assert_equal(2, @t.min_dist(-1))
  end

  def test_fetch_nearest
    @t.add(1)
    @t.add(4)
    @t.add(5)
    @t.add(9)
    @t.add(11)
    assert_equal([4], @t.fetch_nearest(4))
    assert_equal([4], @t.fetch_nearest(3))
    assert_equal([9,11], @t.fetch_nearest(10).sort)
    result = []
    @t.fetch_nearest(10) do |v|
      result << v
    end
    assert_equal([9,11], result.sort)
  end
end
