# Find the maximum difference between the specified price and all prices in the
# daily price list after the specified offset
#
# returns an array of [day, price_difference] where day is < 0 if no positive difference was found.
def find_max(price, offset, daily_prices)
  max_price = 0
  max_day = -1
  daily_prices.each_with_index do |next_price, day|
    if day > offset && (next_price - price) > max_price
      max_price = next_price - price
      max_day = day
    end
  end
  return [max_day, max_price]
end

# Implement a method #stock_picker that takes in an array of stock prices,
# one for each hypothetical day. It should return a pair of days representing
# the best day to buy and the best day to sell. Days start at 0.
#
# stock_picker([17,3,6,9,15,8,6,1,10])
#  => [1,4]  # for a profit of $15 - $3 == $12
#
# Returns [] if no days found.
def stock_picker(daily_prices)

  # Scan through and look for the max difference between any 2 days
  max_price_diff = 0
  max_days = []

  daily_prices.each_with_index do |price, day|
    # puts "Day: #{day} price #{price}"
    if day < daily_prices.length
      test_max_pair = find_max(price, day, daily_prices)
      if test_max_pair[0] > 0 && test_max_pair[1] > max_price_diff
        # puts "max price diff is now #{test_max_pair[1]}"
        max_price_diff = test_max_pair[1]
        max_days = [day, test_max_pair[0]]
      end
    end
  end
  max_days
end
