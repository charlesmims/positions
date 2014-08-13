require_relative "positions"
require "test/unit"

class UnitTests < Test::Unit::TestCase
	def test_string
		assert_equal("400 shares at $8.09 for $3236.0 invested", Position.new(400, 8.09).to_s)
		assert_equal("0 shares at $0.0 for $0.0 invested", Position.new(0,0).to_s)
		assert_equal("-400 shares at $10.0 for $-4000.0 invested", Position.new(-400, 10).to_s)
	end
	def test_profit
		assert_equal(-276.0, Position.new(400, 8.09).profit(7.40))
		assert_equal(0.0, Position.new(100, 8.0).profit(8.0))
		assert_equal(0.0, Position.new(0, 0.0).profit(0.0))
	end
end
