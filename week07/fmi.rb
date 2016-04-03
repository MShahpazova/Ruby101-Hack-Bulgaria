

class Wrapper < BasicObject
   def initialize(target)
    @target = target
    end
   def method_missing(name, *args, &block)
    
    if @target.respond_to?(name)
      @target.public_send(name, *args, &block)
    else  
      Ampersand.new(nil)
    end

  end
end
[Object, NilClass, TrueClass, FalseClass, Fixnum].each do |cls|
 cls.class_eval do
  def &
    ::Ampersand(self)
  end
  
end 
class BasicObject
  def &(*)
    if self == nil
      return nil
    else
     return self
   end
  end
end

class NilClass
  def &(*)
  return nil     
  end   
  def method_missing(method, *args, &block)
      return nil
  end   
end

user = nil
puts user.&.assignments.&.last.&.date
 # puts Fixnum.ancestors
 # puts 6 * 9
  # puts 7 * 7
  p method_foo.bind(a).call
  method_foo = A.instance_method(:foo)
  
  def method_name
    foo = method(:foo)
    self.class.send(:define_method, :bar, foo)  
    foo.call  
  end
