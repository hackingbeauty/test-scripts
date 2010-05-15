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
  attr_accessor :quantity_purchased
  attr_accessor :product_total
end

class CheckOutSystem
  def start
    @hash = Hash.new{|h,k|}
    @specials = Array.new
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
      product.sku = user_input[0]
      product.quantity = user_input[1]
      product.price = user_input[2]
      if !@hash.has_key?(product.sku)
        @hash[product.sku] = product
      else
        item = @hash.fetch(product.sku)
        item.quantity = item.quantity.to_i
        if(item.price != user_input[2])
          calculate_exceptions(product.sku,user_input[1],user_input[2])
        end
      end
    else
      sku = user_input[0]
      if @hash.has_key?(sku)
        item = @hash.fetch(sku)
        item.quantity_purchased = item.quantity_purchased.to_i + 1
      else
        puts 'There is no product with that sku'
      end
    end
  end
  def calculate_exceptions(sku,quantity,new_price)
      puts 'calculating exceptions'
      @specials << {sku => {quantity => new_price}}
      puts @specials.size
  end
  def list_purchases
    total_all = 0
    total_all_format = 0
    product_price = 0
    special_exception = 0
    @hash.each_pair do |key,value|
      price = sprintf('%.2f', value.price)
      @specials.each do |c|
        puts 'inside'
        if c[value.sku]
          array_val =  c[value.sku].to_s
          first_val = array_val[0,1]
          last_val = array_val[array_val.length - 1, 1]
          puts 'quantity_purchased is ' + value.quantity_purchased.to_s
          if value.quantity_purchased.to_i == first_val.to_i
            puts 'x'
            value.product_total = value.quantity_purchased.to_i * first_val.to_i
            special_exception = value.product_total
            puts 'special_exception is ' + special_exception.to_s
          elsif (value.quantity_purchased.to_i <= first_val.to_i)
            puts 'y'
            value.product_total = value.quantity.to_i * value.price.to_i
            puts 'actual quantity less than special case quantity' + value.product_total.to_s
          else value.quantity_purchased.to_i >= first_val.to_i
             puts 'z'
             value.product_total = (value.quantity.to_i * value.price.to_i) + special_exception.to_i
             puts 'actual quantity more than special case quantity ' + value.product_total.to_s
          end#end if
        end#end if
      end#end foreach 
      
      puts 'ya ' + value.quantity.to_s + ' ' + value.quantity_purchased.to_s
      
    end#end foreach
  end#end def
end#end class

CheckOutSystem.new.start