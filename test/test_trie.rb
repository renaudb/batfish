require 'test/unit'
require 'test/helper'

include Batfish

class TestTrie < Test::Unit::TestCase

  def setup
    @t = Trie.new()
  end

  def test_initialize
    assert(@t.root.children.empty?)
  end

  def test_delete
    @t["dinosaur"] = 0
    @t["diplodocus"]  = 1
    @t["diplotomodon"] = 2
    @t["raptor"] = 3
    @t["tyrannosaurus"] = 4
    @t["tyrannotitan"] = 5
    @t["velociraptor"] = 5
    @t.delete("tyrannosaurus")
    assert(!@t.has_key?("tyrannosaurus"))
    assert(@t.has_key?("tyrannotitan"))
    @t.delete("diplo")
    assert(@t.has_key?("diplodocus"))
    assert(@t.has_key?("diplotomodon"))
    @t.delete("raptor")
    assert(!@t.has_key?("raptor"))
    assert(@t.has_key?("velociraptor"))
  end

  def test_fetch
    @t["dinosaur"] = 0
    @t["diplodocus"]  = 1
    @t["diplotomodon"] = 2
    @t["raptor"] = 3
    @t["tyrannosaurus"] = 4
    @t["tyrannotitan"] = 5
    assert_equal(0, @t.fetch("dinosaur"))
    assert_equal(1, @t.fetch("DiPlOdOcUs"))
    assert_equal(nil, @t.fetch("velociraptor"))
    assert_equal(nil, @t.fetch("tyranno"))
  end

  def test_has_key?
    @t.add("dinosaur", 0)
    @t.add("diplodocus", 1)
    @t.add("diplotomodon", 2)
    @t.add("raptor", 3)
    @t.add("tyrannosaurus", 4)
    @t.add("tyrannotitan", 5)
    assert(@t.has_key?("dinosaur"))
    assert(@t.has_key?("DiPlOdOcUs"))
    assert(!@t.has_key?("velociraptor"))
    assert(!@t.has_key?("tyranno"))
  end

  def test_has_value?
    @t.add("dinosaur", 0)
    @t.add("diplodocus", 1)
    @t.add("diplotomodon", 2)
    @t.add("raptor", 3)
    @t.add("tyrannosaurus", 4)
    @t.add("tyrannotitan", 5)
    assert(@t.has_value?(0))
    assert(@t.has_value?(5))
    assert(!@t.has_value?(99))
    assert(!@t.has_value?("dinosaur"))
  end

  def test_empty?
    assert(@t.empty?)
    @t.add("dinosaur", 0)
    @t.add("diplodocus", 1)
    assert(!@t.empty?)
    @t.delete("dinosaur")
    @t.delete("diplodocus")
    assert(@t.empty?)
  end

  def test_each
    @t.add("dinosaur", 0)
    @t.add("tyrannosaurus", 4)
    @t.add("diplotomodon", 2)
    @t.add("tyrannotitan", 5)
    @t.add("raptor", 3)
    @t.add("diplodocus", 1)
    i = 0
    @t.each do |k, v|
      assert_equal(i, v)
      i += 1
    end
  end
end
