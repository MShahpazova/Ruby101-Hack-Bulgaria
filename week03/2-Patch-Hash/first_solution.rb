class Hash
  def pick(*keys)

  	result = {}
  	keys = keys
  	# puts keys.join
    self.each {|key, value| if keys.include?(key) then result[key] = value end}
    result
  end

  def except(*keys)
  	keys = keys
  	Hash.new.tap do |hash| 
    each {|key, value| if !keys.include?(key) then hash[key] = value end }
	end
  end

  def compact_values
    Hash.new.tap do |hash|
    	each {|key,value| hash[key] = value if value}
    end
  end

  def defaults(hash)
     result = self
     hash.each{|k,v| if !result.include?(k) then result[k] = v end}
     	result
  end

  def pick!(*keys)
  	keys = keys
  	self.each {|k,v| self.delete(k) unless keys.include?(k)}
  end
end

 #p ({a: 1, b: 2, c: 3}.except(:a, :b))
 p ({a: 1, b: 2, c: 3}.pick(:a, :b))
 #p ({a: 1, b: 2, c: false, d: nil}).compact_values
 #p  ({a: 1, b: 2}).defaults(a: 4, c: 3)
 p ({a: 1, b: 2, c: 3}.pick!(:a, :b))
# => {:a=>1, :b=>2}