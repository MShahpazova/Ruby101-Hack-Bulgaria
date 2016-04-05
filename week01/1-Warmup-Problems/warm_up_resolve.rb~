def factorial(num)
  arr = Array.new(num){|e| e + 1}
  result = 1
  arr.each {|e| result *= e }
  result
end

def factorial(num)
  num == 1 ? num : num * factorial(num - 1)
end

def fibonacci(num)
  a,b = 0,1
  seq = ""
  1.upto(num) do
    a,b = b,a+b
    seq += "#{a}"
  end
  seq
end

def first_lucas(num)
  Array.new.tap do |seq|
  a,b = 2,1
  1.upto(num) do 
    seq << a
    a, b = b, a + b
      end
    end
  end

def lucas_series(num)
  return 2 if num == 1
  return 1 if num == 2
  puts num
  if num > 1
  return lucas(num - 1) + lucas(num - 2)
  end
end

def count_digits(int)
  int.to_s.size
end

def sum_digits(int)
  int.to_s.chars.map(&:to_i).reduce(:+)  
end

def sum_factorials(num)
  num.to_s.chars.map(&:to_i).inject(0){ |sum, el| factorial(num)}
end

def factorial_digits(n)
    n.to_s.chars.map(&:to_i)
    .map { |d| factorial d }
    .reduce { |a, e| a + e }
end

def hack?(num)
  binary = num.to_s(2)
  binary == binary.reverse if binary.count('1').odd?   
end

def next_hack(num)
  num = num.next
  num = num.next until hack? num
end

def count_vowels(str)
   str.to_enum(:scan, /[aeouiyAEOUIY]/).map { Regexp.last_match }.count
end

def find_next_hack_number(num)
  num += 1
    if check_for_hack_number(num)
        return num
    else
      find_next_hack_number(num)
  end
end

def is_int_palindrome?(int)
  int.to_s.eql? int.to_s.reverse 
end

require 'prime'
def prime?(num)
  Prime.prime?(num)
end

def list_primes(boundary)
  Array.new.tap do |arr| 
  1.upto(boundary).each {|el| arr << el if prime?(el)}
 end
end 

def sum_digits_in_string(str)
str.scan(/[0-9]+/).map(&:to_i).reduce(:+)
end 

def anagram?(word1,word2)
  word1.chars.all? {|letter| word2.include?(letter) && word1.count(letter) == word2.count(letter)}
end

def has_anagram(word, string)
    /[#{word}]/.match(string) != nil
end

def number_balanced?(number)
   mid = number.length/2
   num1 = 0
   num2 = 0
   number.chars.map(&:to_i).each_with_index{|num, index|
    if index < mid
     num1 += num 
    elsif index >= mid + number.length % 2
     num2 += num
    end 
    }
    num1 == num2
end

def insert_zeros(number)
  num_arr = number.chars.map(&:to_i)
  arr = []
  count = 0
  while(count <= number.length) 
    a = num_arr[count].to_i
    b = num_arr[count+1].to_i
    arr << a
    arr << 0 if a.eql?(b) || (a + b) % 10 == 0
    count += 1
    end
  result = arr.join('')
 end

