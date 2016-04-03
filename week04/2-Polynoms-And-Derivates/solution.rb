class Polynom
    
  include Enumerable
	
  def initialize(polynom)
    @monoms = Hash.new(0) 
    @derivatives = Hash.new(0)
    arr = split(polynom)
    result = strip(arr)
     define_parts(result)
  end

  def create_derivatives()
    @derivatives = Hash.new(0)
    @monoms.each {|key,value| 
    @derivatives[key.to_i - 1] = key.to_i * value.to_i }
  end

  def derivatives_to_s
    result = []
    @derivatives.each {|key, value| 
      if key > 0 
        temp_str = value.to_s + "*x" + "^" + key.to_s
        result.push(temp_str)
      elsif key == 0
        temp_str = value.to_s
        result.push(temp_str)
      end 
        result.join(" + ")
   end 

  def split(polynom)
    arr = polynom.split("+")
    result = []
    arr.each {|el| result.push( el.split("^"))}
  end

  def strip(arr)
    result = []
    arr.each {|el| 
    result.push(el.strip)}
    result
  end

  def define_parts(arr)
    arr.each { |el|
	  if el.include?("^")
        add_el_power_more_than_one(el)
	  elsif el.include?("x")
	 	add_power_one_el(el)
	  else 
	    @monoms[0] = el
	  end }
  end

  def add_el_power_more_than_one(element)
    el = element.split("^")   
    if el == "x"
   	  coeff = 1
    else
      coeff = el[0].chop 
    end
      power = el[1]
      @monoms[power] = coeff
  end

  def add_power_one_el(element)
    el = element.chop
	power = 1
	if element == "x"
	  puts element
	  coeff = 1
	else
	  coeff = element.chop
    end
    @monoms[power] = coeff
  end
end
polynom = Polynom.new("2x^3 + x")

#polynom = Polynom.new("2x^3 + 3x + 1")
