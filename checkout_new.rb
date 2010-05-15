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
  attr_accessor :price_list
  def initialize(sku,quantity,price,price_list)
    @sku = sku
    @quantity = quantity
    @price = price
    @price_list = []
  end
end

class CheckOutSystem
  def start
    @hash = Hash.new{|h,k|}
    @prices_arr = Array.new
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
      sku = user_input[0].swapcase!
      quantity = user_input[1]
      price = user_input[2]
      product_arr = Array.new
      product_arr.push [quantity,price]    
      product = Product.new(sku,quantity,price,product_arr)
      # product.sku = user_input[0].swapcase!
      # product.quantity = user_input[1]
      # product.price = user_input[2]
      # product_arr = Array.new
      # product_arr.push [product.quantity,product.price]
      # product.prices << product_arr
      if !@hash.has_key?(product.sku)
        @hash[product.sku] = product
      else
        item = @hash.fetch(product.sku)
        item.price_list << product_arr
        puts item.price_list.size
        item.quantity = item.quantity.to_i + product.quantity.to_i
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
    prod_total_all = 0
    final_total = 0
    @hash.each_pair do |key,value|
      price = sprintf('%.2f', value.price)
      value.price_list.each do |arr|
        puts arr
        # prod_sub_total = arr[0].to_i * arr[1].to_i
        # prod_total_all = prod_total_all + prod_sub_total
      end
      #final_total = final_total + prod_total_all 
      puts "#{key} #{value.quantity} $#{prod_total_all}"
    end
      # final_total_format = sprintf('%.2f',final_total)
      # puts "TOTAL: $#{final_total_format}"
  end
end

CheckOutSystem.new.start