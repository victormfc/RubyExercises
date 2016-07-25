require 'date'

class ShoppingCart

	def initialize
		@prices_table = FileReader.new
		@products = []
	end

	def add (product)
		@products << product
	end

	def item_counter
		@products.length
	end

	def total_cost
		@cost = 0
		@products_prices_pairs = @prices_table.read
		per_element_discount
		multiple_elements_discount
		
	end

	def per_element_discount
		@products.each do |product|
			price = @products_prices_pairs[product.name].to_i
			discount = product.discount(price)
			@cost += price - discount
		end
	end

	def multiple_elements_discount
		
		if item_counter > 5
			@cost - 0.1 * @cost
		else
			@cost
		end
	end

end

class Product 
	attr_accessor :name
	def initialize(name)
		@name = name
	end
	def discount(price)
		0
	end
end

class Fruit < Product
	def discount(price)
		if Date.today.wday == 0 || Date.today.wday == 6
			0.1 * price
		else
			0
		end
	end
end

class Housewares < Product
	def discount(price)
		if price > 100
			0.05 * price
		else
			0
		end
	end
end

class FileReader
	def read
		file = IO.read('prices.txt')
		products = file.split("\n")		
		products_hash = {}
		products.each do |product|
			item = product.split(",")
			products_hash[item[0]] = item[1]
		end
		return products_hash
	end
end

cart = ShoppingCart.new
apple = Fruit.new("apples")
banana = Fruit.new("banana")
vacuum_cleaner = Housewares.new("vacuum cleaner")
rice = Product.new("rice")
anchovies = Product.new("anchovies")
watermelon = Fruit.new ("watermelon")


cart.add(apple)
cart.add(banana) 
cart.add(vacuum_cleaner)
cart.add(rice)
cart.add(anchovies)
cart.add(watermelon)

puts cart.total_cost
