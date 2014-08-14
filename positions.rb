require 'rubygems'
require 'nokogiri'
require 'open-uri'

STALE_AGE = 60     # acceptage age of price data in seconds, limits requests to google


class Position
	attr_accessor :size, :avg_price, :symbol, :last, :elast, :c, :ltt, :last_update

	def initialize(symbol, size, avg_price)
		@symbol = symbol
		@size = size.to_i
		@avg_price = avg_price.to_f
	end

	def update()
		page = Nokogiri::HTML(open("https://www.google.com/finance?q=#{@symbol}"))
		page.to_s.match(/ref_(\d{6,8})_l/)
		ref_num = $1


		def ref_val(ref_num, parameter)
			"span[id='ref_" + ref_num + "_" + parameter + "']"
		end

		@last = page.css(ref_val(ref_num, 'l')).children.to_s.to_f # last trade
		@c = page.css(ref_val(ref_num, 'c')).children.to_s      # change
		@elast = page.css(ref_val(ref_num, 'el')).children.to_s.to_f   # extended market last trade
		@ltt = page.css(ref_val(ref_num, 'ltt')).children.to_s # late trade time
		@last_update = Time.new
	end

	def value
		(@last * @size).round(2)
	end

	def update_age
		if defined? @last_update
			Time.new - @last_update
		else
			Time.new.to_i
		end
	end

	def update_if_stale
		if update_age > STALE_AGE
			self.update
		end
	end

	def current_price
		self.update_if_stale
		if defined? @elast and @elast != 0
			@elast
		else
			@last
		end
	end

	def invested
		@size * @avg_price
	end

	def profit()
		self.update_if_stale
		((current_price - @avg_price) * @size).round(2) 
	end

	def to_s
		"#{@size} shares at $#{@avg_price.round(2)} for $#{self.invested.round(2)} invested"
	end
end

positions = Array.new
positions << Position.new("mnkd", 482, 8.19)
positions << Position.new("mnga", 1000, 1.29)
positions << Position.new("tsla", 8, 249.91)

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

