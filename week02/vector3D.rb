class Vector
  def initialize(*components)
    @components = components.flatten
  @dimension = @components.length
    # Let's make it more interesting here. I wanna initialize the vector with
    # `Vector.new(1, 2, 3, 4)` and expect the
    # same vector.
  end
 attr_reader :components
 attr_reader :dimension
  def dimension
    @dimension
    # Your code goes heres
  end

  def length
    result = 0
    @components.each {|x| result += x * x}
    result = result ** 0.5
    result
    # Your code goes here.
  end

  def [](index)
    value = @components[index]
    value
    # Your code goes here.
  end

  def []=(index, value)
    @components[index] = value
    # Your code goes here.
  end

  def ==(other)
    # if self.components == other.components
    #   true
    # else  false
    # end
    @components.each_with_index {|x, index| if x != other.components[index]
     return false
    end }
    return true
   # Yur code goes here.
  end

  def -(vector_of_same_dimension_or_scalar)
    arguments = []
    if vector_of_same_dimension_or_scalar.is_a?(Integer)
       @components.each {|x| arguments.push(x - vector_of_same_dimension_or_scalar)}
    else  
    if vector_of_same_dimension_or_scalar.dimension == @components.length
       @components.each_with_index {|x, index| arguments.push(x - vector_of_same_dimension_or_scalar.components[index])}
    end
     end 
     Vector.new(*arguments)
     
    end

  def *(scalar)
    arguments = []
    @components.each{|x| arguments.push x * scalar}
    Vector.new(*arguments)
    # Return a new Vector that represents the result
    # Your code goes here.
  end 

  def /(scalar)

    arguments = []
    @components.each {|x| arguments.push(x / scalar)}    
    Vector.new(*arguments)
    #dimensions.each_with_index{|x, index| @dimensions[index] = x/scalar}
    # Return a new Vector that represents the result
    # Your code goes here.
  end

  def dot(vector_of_same_dimension_or_scalar)
    if vector_of_same_dimension_or_scalar.is_a?(Integer)
      @components.each_with_index {|c, index| @components[index] = c * vector_of_same_dimension_or_scalar }
    else 
      if @components.length == vector_of_same_dimension_or_scalar.dimension
         @components.each_with_index {|c, index| @components[index] = c * vector_of_same_dimension_or_scalar.components[index]}
      end
    end
    self.to_s
  end

  def to_s
    @components.join(" ")# Your code goes here.
  end
end


puts 