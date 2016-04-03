class Object
  def singleton_class
    class << self
      self
  end
end

class Object
  def define_singleton_method
    singleton_class.send(:define_method, name, &block)  
  end
end
  
class String
 def to_proc
   proc {|n|
    self.split(".").each {|method_name| 
      n = n.public_send(method_name)
    }
    n
  }
 end
end

  
class Module
  def delegate(name, to:)
    # to = @user
    # self.send(to).send(name)
    variable = self.instance_eval "#{to}"
    variable.send(name)
  end
end

class Proxy < BasicObject
  def initialize(target_object)
    @target_object = target_object
  end

  def method_missing(method, *args, &block)  #blocks
    @target_object.send(method, *args, &block)
  end

  def respond_to?(method, include_private = false)
      @target_object.respond_to?(method, true)
  end
end

  class NilClass
    def method_missing(method, *args, &block)
        return nil
    end      
  end

class Module

  def private_attr_reader(*args)
    args.flatten.each |arg| do
    define_method(arg) do 
    instance_variable_get("@#{arg}")
   end
  private arg
  end
end
  													
  def private_attr_writer(*args)
  args.flatten.each |arg| do
  define_method(arg+"=") do
  instance_variable_set("@#{arg}")
    end
    private arg
  end
end

class Module

  def protected_attr_reader(*args)
    args.flatten.each |arg| do
      define_method(arg) do
        instance_variable_get("@#{arg}")
      end
    protected arg
  end

  def protected_attr_writer(*args)
    args.flatten.each |arg| do
      define_method(arg+"=") do
        instance_variable_set("@#{arg}")
    end
    protected arg
  end


# class Module
#   def cattr_reader(*args)
#     singleton_class.class_eval do 
#       args.flatten.each |arg| do
#         define_method(arg) do 
#           instance_variable_get("@@#{arg}")
#         end
#       end
#     end
#   end
# end


# proxy = Proxy.new [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# # proxy.sizes
# puts proxy.respond_to? :size
# puts proxy.respond_to? :zzzz
# num = nil
# puts nil.size
# p (1..5).map(&"pred.pred")