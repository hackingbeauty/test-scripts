#!/usr/bin/ruby

# Mark Muskardin - 3/8/09

# Create products and do the following:
  # Get user input.  If user enters "exit", quit the program and provide a total
  # Enter a product sku, quantity, and price
  # If sku has already been entered, update quantity
  # List total purchases of products entered
  # Note: Price is using floating point precision - in the real world this can lose precision  
  # Note: Could use BigDecimal for fixed-precision arithmetic - outside libraries not permitted for exercise
  
class Product
  attr_accessor :sku
  attr_accessor :quantity
  attr_accessor :price
end

class CheckOutSystem
  def start
    @hash = Hash.new{|h,k|}
    @price_arr = Array.new
    while true
      puts "Please enter a product and hit enter.  Type \"exit\" when you would like a final total."
      STDOUT.flush
      user_input = gets.chomp.split(" ") # an array of strings
      if user_input[0] == 'exit'
        list_purchases
        Kernel.exit
      end
      add_product(user_input)
    end
  end
  def add_product(user_input)
    if (user_input.length > 1)
      product = Product.new
      product.sku = user_input[0].swapcase!
      product.quantity = user_input[1]
      
      @price_arr << {user_input[1] => user_input[2]}
      product.price = @price_arr

      if !@hash.has_key?(product.sku)
        @hash[product.sku] = product
      else
        item = @hash.fetch(product.sku)
        item.quantity = item.quantity.to_i + product.quantity.to_i
        puts 'boo'
        #item.price << @price_arr
      end
    else
      sku = user_input[0].swapcase!
      if @hash.has_key?(sku)
        item = @hash.fetch(sku)
        item.quantity = item.quantity.to_i + 1

      else
        puts 'There is no product with that sku'
      end
    end
  end
  def list_purchases
    puts "listing purchases"
    total_all = 0
    total_all_format = 0
    @hash.each_pair do |key,value|
      value.price.each do |sku|
        puts sku

   
      end
      # value.price.each do |arr|
      #   puts arr
      # end
      # price = sprintf('%.2f', value.price)
      # puts "#{key} #{value.quantity} $#{price}"
      # total_price = value.quantity.to_i * value.price.to_f
      # total_all = total_all + total_price
      # total_all_format = sprintf('%.2f',total_all)
    end
      puts "TOTAL: $#{total_all_format}"
  end
end

CheckOutSystem.new.start