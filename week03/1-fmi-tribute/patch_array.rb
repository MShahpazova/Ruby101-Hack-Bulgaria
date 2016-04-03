class Array
  def to_hash
  	hash = {}
    self.each {|element| hash[element[0]] = element[1] }		
    hash
  end

  def index_by
	hash = {}  	
	self.each {|element| hash[yield(element)] = element}
	hash
  end
  
  def subarray_count(sub_arr)
  	count = 0
  	self.each_cons(2) {|a| if a == sub_arr; count +=1 end }
  	count
  end
  
  def occurances_count
    Hash.new.tap do |hash|
      hash.default = 0
      unique_values = self.uniq
      unique_values.each {|char| occ = self.join("").scan(/#{char}/); hash[char] = occ.length}
    end
  end
end


# occurences = [:a, :a, :b].occurences_count

# occurences[:a]    # 2
# occurences[:b]    # 1
# occurences[:c]    # 0

# p occurences      # {a: 2, b: 1}
p (["a", "a", "b"]).occurances_count