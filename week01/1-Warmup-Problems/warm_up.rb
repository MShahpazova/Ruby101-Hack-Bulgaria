def faktorial(num)
 	result = 1
  while (num > 0) do
	  result *= num 
	  num -= 1
   end
	return result
end

def faktorial(num)
	if num == 1
	return 1
	else 
	faktorial(n - 1) * n
	end
end

def find_lucas_num(num)
	if num == 0 
	 return 2
	elsif num == 1 
	 return 1
  elsif num > 0  then return find_lucas_num(num - 1) + find_lucas_num(num - 2)
	end
end

def count_digits(num)
	result = num.chars.count
	result
end

def count_sum_of_digits(num)
	result = 0
	count = 0
	while (count < num.length) do
	result += num[count].to_i
	count+=1
	end
	  result
end

def sum_faktorial_digits(num)
	result = 0
	count = 0 
	while (count < num.length) do
		result += faktorial(num[count].to_i)
		count += 1
	end
	result
end

def calculate_fibonacci_number(num)
	index = 0
	a = 0
	b = 1
	c = 0
	sequence = []
	sequence.push(b)
	while (index < num - 1)
		c = a + b
		sequence.push(c.to_s)
		a = b
		b = c
		index += 1
	end
	result = sequence.join
	result
end

def hack_number?(num)
	bin_num = num.to_s(2)
	reversed_bin_num = bin_num.reverse 
	count_of_digits = bin_num.length
	if (count_of_digits.odd? and bin_num == reversed_bin_num)
		 true 
	else
	    false
	end
end

def next_hack_number(num)
	result = num + 1
	while(true)

	if(hack_number?(result))
	  return result
	else result = result.next
	end
	end
end

def count_vowels(str)
	result = str.scan(/[aeouiyAEOUIY]/).count
	result
end

def count_consonants(str)
	result = str.scan(/[B-DF-HJ-NP-TV-Zb-df-hj-np-tv-z]/).count
	result
end

def palindrome?(intNum)
    numberStr = intNum.to_s
	reversedStr = numberStr.reverse
	if numberStr == reversedStr
		 true
	else false
	end
end

def palindrome_score(number)

	if palindrome?(number)
		1
	else 
		return 1 + palindrome_score(number.to_i + number.to_s.reverse.to_i)
	end
end

def find_smaller_palindrome(number)
	while(true)
		number -= 1 
		if palindrome?(number)
			return number 
		end
	end	
end

def check_if_prime(num)
	divider = 2
	max_divider = Math.sqrt(num).to_i
	is_prime = true
	has_passed = false
	while (is_prime && divider <= max_divider)
		if num % divider == 0
				is_prime = false
		end
		if divider == max_divider && is_prime == true
			has_passed = true
		end
		divider += 1
	end
	if num || has_passed == true
		true
	else false
	end
end

def list_prime_numbers(boundary)
	num = 1
	list = []
	while num < boundary
		if check_if_prime(num)	
			list.push(num)
		end
		num += 1
	end
	list.join(",")
end

 def sum_nums_in_string (string)
 	list_nums = string.split(/[^0-9]+/)
 	result = 0
 	for i in 0..list_nums.length
 		result += list_nums[i].to_i
 	 end
 	 result
 end

def number_balanced?(num)
	first_result = 0
	second_result = 0
	first_count = 0
	second_count = num.length / 2
	while first_count < second_count
		first_result += num[first_count].to_i
		first_count += 1
	end
	if num.length % 2 != 0
		second_count += 1
	end
	while second_count <= num.length
		second_result += num[second_count].to_i
		second_count += 1	
	end
	if first_result == second_result
		true
	else false
	end
end

def palindrome?(string)
	 string.reverse == string
end

def longest_palidrome(s)
	if s.length == 0
		return 0
	end
 	first = 0
	last = s.length
	result = 1
	while first < last
		count = first
		while count <= last
 		substr = s[first, count]
			if substr.reverse == substr
				if substr.length > result
					result = substr.length
				end
			end
			count += 1
		end
		first += 1
	end
	if result > 0
		return result
	end
end

puts longest_palidrome((ARGV[0]))

 # puts palindrome?(ARGV[0])