class RomanNumbers

  @symbols = {
   "I"  => 1,
   "V" => 5, 
   "X" => 10,
   "L" => 50,
   "C" => 100,
   "D" => 500,
   "M" => 1000
  }
 
  def self.const_missing(num)
    sum = 0
    arr = num.to_s.chars
    index = 0
    while index < arr.length
     first_value = @symbols[arr[index].to_s]
     second_value = @symbols[arr[index + 1].to_s]
     if second_value == nil
        sum += first_value
        break   
     end 
      if first_value < second_value
      sum += second_value - first_value
      index += 1
      else 
      sum += first_value
      end
      index += 1
    end
   sum
  end
end

 # puts RomanNumbers::XXX
puts RomanNumbers::XIX
puts 
