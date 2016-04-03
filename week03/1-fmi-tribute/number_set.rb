class NumberSet
	include Enumerable
	
	attr_accessor :set
	
	def initialize(*arg) #this is a list
		#values = arg.flatten.uniq
		values = arg.flatten.to_a.uniq
        @set = values
        # values = arg.flatten.to_a
		# @set  = arg.map {|element| element.code}
		# .uniq
		# .map {|code| element.get(code)}
		# @set = values.uniq_by(&:code)
	end


	def each(&block)
		@set.each(&block)// why?
	end

    def size
    	@set.size
    end

    def is_empty?
    	@set.is_empty?
    end

    def [](filter)
    	ns = NumberSet.new
    	#/ns << n/
    	self.each do |n|
    		ns<<n if filter.satisfies? (n)
    	end
    	ns
    end

	def <<(value)
			@set << value unless @set.include?(value)
    end
    
	def to_s
		@set.join(" ")
	end
end

class Filter
	def initialize(&block)
		@predicate = block
	end

	def satisfies?(x)
		@predicate.call(x)
	end

	def |(other)
		Filter.new {|num| self.satisfies?(num) || other.satisfies?(num)}
	end

	def &(other)
		Filter.new {|num| self.satisfies?(num) && other.satisfies?(num)}
	end 
end

class SignFilter

	def initialize(sign)
       @sign = sign
    end

    def |(other)
    	Filter.new {|num| self.satisfies?(num) || other.satisfies?(num)}
    end

    def &(other)
       filter.new {|num| self.satisfies?(num) && other.satisfies?(num)}
    end

	def satisfies?(x)
		predicate = case @sign 
		when :positive then lambda {|num| num > 0}
		when :non_positive then lambda {|num| num <= 0}
		when :negative then lambda {|num| num < 0}
		when :non_negative then lambda {|num| num >= 0}
	    end
	    predicate.call(x)
	end
end

class TypeFilter

	def initialize(type)
		@type = type
	end

	def satisfies?(x)
			predicate = case @type
		when :integer then lambda {|num| num.is_a?(Integer)}
		when :real then lambda {|num| num.is_a?(Float) || num.is_a?(Rational)}
		when :complex then lambda {|num| num.is_a?(Complex)}
		end
		predicate.call(x)
	end

    def &(other)
    	Filter.new {|num| self.satisfies?(num) && other.satisfies?(num)}
    end

	def |(other)
		Filter.new {|num| self.satisfies?(num) || other.satisfies(num)}
	end
end

# filter = SignFilter.new(:positive)
# puts filter.satisfies?(-3)
# puts filter.satisfies?(5)

# filter_neg = SignFilter.new(:negative)
# puts filter_neg.satisfies?(5)
# puts filter_neg.satisfies?(-5)

# filter = SignFilter.new(:non_negative)
# puts filter.satisfies?(0)
# puts filter.satisfies?(-2)
# puts filter.satisfies?(2)

# filter = SignFilter.new(:non_positive)
# puts filter.satisfies?(2)
# puts filter.satisfies?(-1)
# puts filter.satisfies?(0)

 even_filter = TypeFilter.new(:integer)
# puts filter.satisfies?(5)
# puts filter.satisfies?(0.5)

# filter = TypeFilter.new(:real)
# puts filter.satisfies?(1)
# puts filter.satisfies?(0.5)

# filter = TypeFilter.new(:complex)
# puts filter.satisfies?(2.5+3i)
# puts filter.satisfies?(5)

 #filter = Filter.new {|x| x.even?}
# puts filter.satisfies?(5)
num_set = NumberSet.new ([2,3,4,5,6,7,8,9])
odd = Proc.new {|x| x.odd?}
odd_nums_filter = Filter.new(&odd)
#puts f2 & even_filter
#p num_set[Filter.new {|x| x.odd?}].to_a
num_set_2 = num_set[odd_nums_filter]
p num_set
p num_set_2
#num_set.each {|num| num[f2]}

#puts  f2.satisfies? 5
