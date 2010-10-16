require 'test/unit'
require_relative '../lib/forkout'

class TestForkout < Test::Unit::TestCase
  def test_1
    results = (1..10).to_a.forkout {|i| i}
    assert_equal 10, results.length
    assert_equal 10, results.max
  end

  def test_2
    results = (1..10).to_a.forkout {|i| i}
    assert_equal 10, results.length
    assert_equal 1, results.min
  end

  def test_3
    results = (1..10).to_a.forkout {|i| i}
    assert_equal 10, results.length
    assert_equal 1, results.min
  end

  def test_4
    results = (1..10).to_a.forkout {|i| i}
    assert_equal 10, results.length
    assert_equal 1, results.min
  end

  def test_5
    results = (1..10).to_a.forkout {|i| i}
    assert_equal 10, results.length
    assert_equal 1, results.min
  end
end
