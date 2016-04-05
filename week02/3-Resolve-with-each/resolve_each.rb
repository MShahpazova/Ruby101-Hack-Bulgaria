# def integer_to_list_digits(number)
#    digits = number.to_s.chars
#    digits.collect {|d| d.to_i}
#    digits.join(" ")
# end
# puts integer_to_list_digits(ARGV[0].to_i)

def nth_lucas(n)
	a = 0
	b = 1
	2.upto(n) do
	a,b = b, a + b	
	end
	
	b
end
# puts nth_lucas(ARGV[0].to_i)

def first_lucas(n)
	1.upto(n).map { |index| nth_lucas index  }
end
#puts first_lucas(ARGV[0].to_i)

# def faktorial(n)
# 	1.upto(n).reduce(1, :*)
# end
# puts faktorial(ARGV[0].to_i)

def faktorial(n)
	1.upto(n).inject {|product, n| product * n}
end
#puts faktorial(ARGV[0].to_i)
def first_fibs(n)
  a, b = 1, 1
  result = [a]

  2.upto(n) do
  	puts result.join
    a, b = b, a + b
    result << a
  end

  result
end
#puts first_fibs(ARGV[0].to_i)
def to_digits(n)
	n.to_s.chars.collect { |d| d.to_i  }
end
#puts to_digits(ARGV[0].to_i)

def sum_digits(n)
	digits = to_digits(n)
	digits.reduce{|sum, d| sum += d}
end

# puts sum_digits(ARGV[0].to_i)
def hack?(n)
	bn = n.to_s 2
	bn.count('1').odd? && bn.reverse == bn
end
def next_hack(n)
	n = n.next
	n = n.next until hack? n
	
end

def count_consonants(str)
  consonants = 'bcdfghjklmnpqrstvwxz'.chars

  str.downcase
     .chars
     .select { |ch| consonants.include? ch }
     .length
end
# puts count_consonants(ARGV[0])