require_relative 'positions.rb'

positions = Array.new
positions << Position.new("mnkd", 582, 7.95)
positions << Position.new("mnga", 1000, 1.29)

loop do
	total_profit = 0
	positions.each do |position|
		position.update_if_stale
		puts "#{position.symbol.upcase}, $#{position.avg_price}, $#{position.current_price}, #{position.size}, $#{position.invested}, $#{position.value}, $#{position.profit}"
		total_profit += position.profit
	end
	puts total_profit.round(2)
	STDOUT.flush
	sleep(60)
end