
class Product
  require 'bigdecimal'
  require 'bigdecimal/util'

  attr_reader :name, :price, :promotion
  MAX_LENGTH_PRODUCT_NAME = 40
  PRICE_UPPER_BOUNDARY =  BigDecimal.new("999.99")
  PRICE_BOTTOM_BOUNDARY = BigDecimal.new("0,01")

  def initialize(name, price, promotion)
    @name = set_name(name)
    @price = set_price(price)
    @promotion = set_promotion(promotion)
  end

  def set_name(name)
    if name.length > MAX_LENGTH_PRODUCT_NAME || name.length <= 0
      raise "Name of product must be between 0 and 40 symbols"
    else
      @name = name
    end
  end

  def set_price(price)
    price_bigDec = price.to_d
    if price_bigDec > PRICE_UPPER_BOUNDARY || price_bigDec < PRICE_BOTTOM_BOUNDARY
      raise "Price must be between 0.01 and 999.99"
    end
    @price = BigDecimal.new(price_bigDec)
  end

  def set_promotion(promotion)
    if promotion != nil
      name_promotion = promotion.keys[0]

      value_promotion = promotion[name_promotion]
      # puts "This is the value of the promotion #{value_promotion}"
      case name_promotion
      when :threshold
        @promotion = Threshhold.new(value_promotion)
      when :get_one_free
        @promotion = GetOneFree.new(value_promotion)
        # puts "This is the name of promotion #{name_promotion}"
      when :package
        @promotion = Package.new(value_promotion)
        # puts promotion
      else
        @promotion = nil
      end
    else
      @promotion = nil
    end
  end
end

class Cart
  attr_reader :products_added
  include InvoiceFormatter


  def initialize(inventory)
    @inventory = inventory
    @products_added = {}
  end

  def calculate_discounts
    # @products_added.each {|k,v| puts "product: #{k.name} quantity:  #{v.truncate(2).to_s('F')}"}
    products_on_promotion = @products_added.select {|pr, value| pr.promotion != nil}
    total_discount = 0.to_d
    products_on_promotion.each {|k,v| puts "product: #{k.name} quantity:  #{v.truncate(2).to_s('F')}"}
    products_on_promotion.each do |k,v|
      promotion = k.promotion
      total_discount += promotion.apply(k,v)
    end
    total_discount
  end

  def calculate_total_without_discounts
    sum = 0
    @products_added.each {|k,v| sum += k.price * v.to_d }
    sum
  end

  # def calculate_discount_of_same_products(product, quantity)
  #     promotion = product.promotion
  #     discount = promotion.apply(pr)

  # end

  def calculate_price_of_same_products(product, quantity)
    product.price * quantity.to_d
  end

  # def use_coupon(coupon_name)
  #   coupons = inventory.coupons
  #    coupon = coupons.find(|coupon| coupon.name == coupon_name)
  #    if coupon != nil

  #    end
  # end

  def total()
    sum = calculate_total_without_discounts
    sum -= calculate_discounts
    sum
  end

  def get_product(name)
    product = @inventory.products.find {|x| x.name == name}
    if product == nil
      raise "This product is not available in the shop."
    end
    product
  end

  def add_product(product_name, quantity=1)
    #we need this to track the quantity of each product
    product = get_product(product_name)

    if !@products_added.include?(product)
      quantity = @products_added[product] = quantity.to_d
    else
      @products_added[product] += quantity.to_d
    end
  end

end
# we need a hash to keep all products added together with their quantity
# has a list_of products

# has a method "Add" //add method should have a default second parameter - 1
# has a method "invoice"
# has a method "total"
# has a method use

class Threshhold
  attr_reader :amount, :percent

  def initialize(hash)
    @amount = hash.keys[0]
    @percent = hash[@amount]/100.to_d
    end

    def apply(product, quantity)
      amount_on_promo = (quantity - @amount).to_d
      return 0 if amount_on_promo <= 0
      
      amount_on_promo * product.price * percent
    end
end
  
class Package

  def initialize(hash)
    @amount = hash.keys[0]
    @percent = hash[@amount] / 100.to_d
  end

  def apply(product, quantity)
    #remainder
    items_to_subtract = quantity.to_d % @amount
    return 0 if quantity / @amount.to_d < 1
    items_on_discount = quantity - items_to_subtract
    items_on_discount * @percent
  end
  def to_s
    "number of items: #{@amount}\ndiscount percent: #{@percent}"
  end
end

class GetOneFree

  def initialize(hash_value)
    @count = hash_value
  end

  def apply(product, quantity)
    # puts quantity.to_s('F')
    free_items = quantity/@count
    return 0.to_d if free_items <= 1
    free_items * product.price
  end
  def to_s
    "every #{@count} is free"
  end
end

class Inventory

  require 'set'
  attr_reader :products

  def   initialize
    @products = Set.new
    @coupons = Set.new
  end

  def register(name, price, promotion = nil)
    product = Product.new(name, price, promotion)
    # puts product.name
    if @products.include?(product)
      raise "Product already added"
    else
      @products << product
    end
  end

  def register_coupon(name, info)
    coupon = Coupon.new(name, info)
    @coupons << coupon
  end

  def new_cart
    Cart.new(self)
  end
  # method register ( a product)
  # method_register coupon //two kinds of coupons, for the whole amount
  # for certain percent of the amount
  # the discount for the coupon is applied after the promotions discount is applied
end

class Coupon

  def initialize(name, info)
    @name = name
    @discount_type = info.keys[0]
    @value = info[@discount_type].to_d
  end

  def initialize(name, info, something_else)
    body
  end

  def calculate_discount(total)
    case @discount_type
    when :percent
      total * @value/100.to_d
    when :amount
      @value
    end
  end
end

module InvoiceFormatter
  BORDER = "+"+"-" * 48 + "+" + "-" * 10 +"+"
  TEXT_FORMAT = "| %-40s %5s | %8s"
  PRODUCT_FORMAT = "| %-40s %7s|%5.2f|"

  def format_promotion_product
    @products_added.map do |product, quantity|
      # format = [PRODUCT_FORMAT %[product quantity calculate_price_of_same_products(product, quantity)]]
      puts PRODUCT_FORMAT %[product quantity calculate_price_of_same_products(product, quantity)]
    end
  end
end

class Cart
  include InvoiceFormatter
end


inventory = Inventory.new
# inventory.register("green tea", "4.40", get_one_free: 2)
inventory.register("coffee", "3.50")
inventory.register("mascara", "30", package: {2 => 20})
inventory.register 'Earl Grey', '1.00', threshold: {10 => 50}
inventory.products.each {|pr|
puts pr.promotion if pr.promotion != nil}

# inventory.register("cheese", "7.20")
# puts inventory.products
cart = inventory.new_cart
# def test_string_format
#   # "| %-40s %7s|%5.2f" % [ "ID", 9999, "Maria" ]

#   # "| %-40s %7s|%5.2f|" %[Green tea 8 22.32]
# end
# puts cart.BORDER
# puts cart.TEXT_FORMATTER
# puts cart.PRODUCT_FORMATTER %[Green tea 8 22.32]
puts test_string_format
cart.add_product("coffee", 2)
cart.add_product("mascara")
cart.add_product("green tea")
cart.add_product("mascara")
cart.add_product("coffee")
cart.add_product("Earl Grey", 20)
cart.format_promotion_product
# cart.products_added.each {|k,v| puts k.promotion if k.promotion != nil}
# puts cart.total
# product = cart.get_product("green tea")
# puts product.price
# cart.total.truncate(2).to_s('F')
# puts cart.calculate_discounts.truncate(2).to_s('F')
# puts cart.total.truncate(2).to_s('F')
# cart.add_product("cheese", 2)
# # cart.add_product("cheese", 2)
# puts cart.total.truncate(2).to_s('F')
# puts cart.products_added
# cart.add_product("chocolate")

# def test_percentage()
#   result = 70.to_d / 100.to_d
#   puts result.inspect
# end

# puts test_percentage
# Следните неща пораждат грешка:

#     Име на продукт, което не съществува в инвентара.
#     Един продукт да присъства в количката 0 или < 0 пъти.
#     Един продукт да присъства в количката повече от 99 пъти.
