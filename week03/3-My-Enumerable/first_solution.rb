
module MyEnumerable

  # def map
  #   Array.new.tap do |arr|
  #     each do  |element|
  #     value = yield element
  #     arr << value
  #   end
  #   # Your code goes here
  # end
   def map(&block)
    return enum_for(:map) unless block_given?
     arr = []
     self.each {|element| arr << block.call(element)}
     arr
   end

  # def collect
  #    Array.new.tap do |arr|
  #     each do |element|
  #    arr << element if yield(element)
  #       end  
  #     end  
  #  end
 
   def select (&block)
     return enum_for(:select) unless block_given?
     Array.new.tap do |arr|
     each{|element| arr <<  element if block.call(element) == true}
   end
 end

  # def reject
  # Array.new.tap do |arr|
  #   each do |element|
  #     arr << element if yield(element) == false
  #     end
  #   end
  #  end
  def negate_block(&block)
    Proc.new { |x| !block.call(x)}
  end

  def reject(&block)
   select(negate_block(&block))
  end
  
  # def reduce(initial = nil, &block)
  #   if initial == nil
  #     initial = get_first
  #   end
  #   self.each {|element|  initial = block.call(initial, element)}
  #   initial
  #   #Your code goes here
  # end
  def reduce(accumulator = nil, operation = nil, &block)
    if accumulator = nil && operation = nil && block.nil?
      raise ArgumentError, "You must provide an operation or a block"
    end
    if operation && block
      raise ArgumentError, "You must provide either an operation symbol or a block, not both"
    end
    if operation.nil? && block.nil?
      operation = accumulator
      accumulator = nil
    end
   
   
    block = case operation
      when Symbol
      lambda {|acc, value| acc.send(operation, value) } 
      when nil
      block   
      else raise ArgumentError "The operation provided must be a symbol"
      end
    if accumulator.nil?
      ignore_first = true
      accumulator = first
    end
    index = 0

    each do |element|
      unless ignore_first && index == 0
        accumulator = block.call(accumulator, element)
      end
      index += 1
    end
    accumulator
  end

  def any?
     select.size > 0 
  end

  def all?
    select.size == size
  end

  def include?(element)
    el_to_compare = element
    flag = false
    self.each {|element|  flag = true if element == el_to_compare}
    flag
  end

  def count(element = nil)
    count = 0
    if element != nil
      each {|x| count += 1 if x == element } 
    else 
      each {|x| count +=1}
    end
    count
  end

  def size
    size = 0
    each {|x| size += 1}
    size
  end
   
   def get_first
   element = nil
   each {|x| element = x; break}
   element
   end

   def min
   min = get_first
   each {|x| min = x if x < min}
   min
   end

  def min_by(&block)
    min_value = block.call(get_first)
    min_element = get_first
    each { |element|
      if block.call(element) < min_value
        min_value = block.call(element)
        min_element = element
      end
    }
    element
  end

  # def max    
  #   max_value = get_first
  #   each {|element| max_value = element if element > max_value}
  #   max_value
  # end

  # def max_by(&block)
  #   max_value = block.call(get_first)
  #   max_element = get_first
  #   each {|element| 
  #     if block.call(element) > max_value
  #       max_value = block.call(element)
  #       max_element = element
  #     end
  #     max_element
  #   }
  # end
    def max
      reduce {|acc, max| 
         if acc > max 
          acc = max
           else 
            acc
          end
        }
     end
  def take(n)
    Array.new.tap do |arr|
      count = 0
      each {|element| 
        arr << element if count < n
        count += 1
     }
    end
  end

  def take_while(&block)
    Array.new.tap do |arr|
      each {|element| 
        arr << element if block.call(element)}
    end
  end

  def drop(n)
    Array.new.tap do |arr|
      count = 0
      each {|element| 
        arr << element if count > n 
        count += 1}
      end
  end

  def drop_while
    Array.new.tap do |arr|
      each {|element|
        arr << element unless block.call(element)}
    end 
  end
end

class Collection
    include MyEnumerable

    def initialize(*data)
      @data = data
    end

    def each(&block)
      @data.each(&block)
    end

    def ==(otherCollection)
      @data == otherCollection.data
    end

    def get(index)
      return @data[index]
    end

end

  collection = Collection.new(*1..10)

  p collection.reduce(0) { |sum, n| sum + n }

  p collection.map.select.with_index{|num, index| puts "Number: #{num}, Index #{index}"}
  
  #p collection.collect {|n| n < 4}

   # p collection.include? (5)
   # a = ["maria", "iva", "niki"]
   # p a.max_by {|x| x.length}
   # p collection.count()
   # p collection.drop(3 )
   # p collection.take(3)
    p collection.max