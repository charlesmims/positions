positions
=========

Stock Portfolio tool


This is a work in progress.  I'm learning ruby and thought this would be a fun way to get some experince with that.
Currently it has some stocks bought at a certain price hard coded into positions.rb, and a tests file
that needs to be updated. 

So far, this tool make use of screen scraping google finance with ruby's nokogiri, does some calculation and formatting of the results, and exposes this with attr_accessors.  At the bottom there's a loop do that updates every minute and prints out symbol, price purchased, current price, quantity, purchase cost, current value, profit; and then summarizes profit at the end.

```
$ ruby positions.rb 
MNKD, $8.19, $7.09, 482, $3947.58, $3417.38, $-530.2
MNGA, $1.29, $1.14, 1000, $1290.0, $1140.0, $-150.0
TSLA, $249.91, $261.28, 8, $1999.28, $2090.24, $90.96
-589.24
```

Ideas for improvements: 

[ ] move tracked positions into a db file

[ ] track historical pricing data in a db file

[ ] add twitter feed and NLP sentiment rating for each symbol

[ ] scrape target pricing from web articles

[ ] fundamentals


