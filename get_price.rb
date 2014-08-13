require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_prices(symbol)
	page = Nokogiri::HTML(open("https://www.google.com/finance?q=#{symbol}"))
	ref_num = page.to_s.match(/ref_(\d{6})_l/)[0][4..9]

	def ref_val(ref_num, parameter)
		"span[id='ref_" + ref_num + "_" + parameter + "']"
	end

	puts ref_val(ref_num, "l")
	l = page.css(ref_val(ref_num, "l")).children.to_s.to_f

	return {l: l}
end


prices = get_prices('mnkd')
# puts "last trade: #{prices[0]},   extended hours: #{prices[1]}"
p prices