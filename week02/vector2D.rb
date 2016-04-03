class Vector2D
  def initialize(x, y)
    @x, @y = x, y
  end

  def x
    @x
  end

  def x=(value)
    @x = value
  end

  def y
    @y
  end

  def y=(value)
    @y = value
  end

  def length
    (@x * @x + @y * @y) ** 0.5
    # Your code goes here.
  end
  def normalize
    @x = @x / length
    @y = @y / length
    # Your code goes here.
  end

  def ==(other)
    if @x == other.x && @y == other.y
      true
    else  false
    end
    # Your code goes here.
  end

  def +(other)
    Vector2D.new(@x + other.x, @y + other.y)
    # Return a new Vector2D that represents the result
    # Your code goes here.
  end

  def -(other)
    Vector2D.new(@x - other.x, @y - other.y)
    # Return a new Vector2D that represents the result
    # Your code goes here.
  end

  def *(scalar)
    Vector2D.new(@x * scalar, @y * scalar)
    # Return a new Vector2D that represents the result
    # Your code goes here.
  end

  def /(scalar)
    Vector2D.new(@x / scalar, @y / scalar)
    # Return a new Vector2D that represents the result
    # Your code goes here.
  end
    def dot(other)
      Vector2D.new(@x * other.x, @y * other.y)
    # Return the dot product of the two vectors
    # https://en.wikipedia.org/wiki/Dot_product#Algebraic_definition
  end

  def to_s
    result = "(#{@x},#{@y})"
    # Your code goes here.
  end
end

v1 = Vector2D.new(1, 2)
v2 = Vector2D.new(3, 4)
