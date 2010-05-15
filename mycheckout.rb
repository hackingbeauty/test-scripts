#!/usr/bin/ruby

class Product
  attr_accessor :sku
  attr_accessor :quantity
  attr_accessor :price
  attr_accessor :quantity_price
  attr_accessor :quantity_purchased
  attr_accessor :product_total
  # attr_accessor :exceptions - you can assign this an array as well
end

class CheckOutSystem
  #We start by getting the user's input
  def start
    @products = Hash.new{|h,k|}
    # @exceptions = Array.new
    # @exceptions = Hash.new{|h,k|}
    @exceptions = {}
    while true
      puts "Please enter a product and hit enter.  Type \"exit\" when you would like a final total."
      STDOUT.flush
      user_input = gets.chomp.split(" ") #An array of strings
      if user_input[0] == 'exit'
        tabulate_purchases
        Kernel.exit
      else
        add_product(user_input) 
      end
    end#end while
  end#end def
  
  def add_product(user_input)
     if (user_input[0] != nil)
       puts 'adding a product'
       #If the user's input is greater than 1 item, we're creating an inventory
       #If the user's input is 1 item it should be an sku - which means we're making purchases 
       sku = user_input[0]
       quantity = user_input[1]
       price = user_input[2]
       if (user_input.length > 1)
         add_inventory(sku,quantity,price)
       else
         make_purchase(sku)
       end#end if
      end#end if
  end#end def
  
  def make_purchase(sku)
    if @products.has_key?(sku)
      puts 'i am making a purchase'
      product = @products.fetch(sku)
      product.quantity = product.quantity.to_i + 1
      puts product.quantity
    else
      puts 'Cannot find product with that sku'
    end
  end
  
  #Add the inventory of products
  def add_inventory(sku,quantity,price)
    #Instantiate a Product object
    product = Product.new
    product.sku = sku
    product.quantity_price = quantity
    product.price = price
    #If the product does not have the sku just entered, insert the product into the hash
    #Otherwise, find the product with the relevant sku in the hash
    if !@products.has_key?(product.sku)
      @products[product.sku] = product
    else
      existing_product = @products.fetch(product.sku)
      if(product.price != existing_product.price)
        calculate_exceptions(product.sku,product.quantity,product.price)
      end
    end#end if
  end#end def
  
  def calculate_exceptions(sku,quantity,price)
    #@exceptions << {sku => {quantity => price}}
    @exceptions[sku] = (@exceptions[sku] || {}).merge({ quantity => price })
    # @exceptions.each { |sku, price_for_qty| price_for_qty[2] }
    
    puts 'calculating an exception'
  end#end def
  
  def tabulate_purchases
    @products.each_pair do |key,value|
      # puts value.sku
      @exceptions.each do |c|
        puts c[0]
        puts c[1]
        # if c[value.sku]
        #   puts 'there is an exception'
        #   tabulate_exceptions(c[value.sku])
        # end
      end#end loop
    end#end loop
  end#end def
  
  def tabulate_exceptions(val)
    array_val =  val.to_s
    first_val = array_val[0,1]
    last_val = array_val[array_val.length - 1, 1]
    puts 'array_val is ' + array_val
  end#end def
  
end

CheckOutSystem.new.start