# class Symbol
#   def to_proc
#     proc {|element| element.send(self)}
#   end
# end

# class Module
#   def around_method(method_name, &around)
#     original_method = instance_method(method_name)
#     define_method(method_name) do |*args, &block|
#     around.call(self, original_method.bind(self), *args)
#     original_method.call(*args, &block)
#   end
# end

# class Fixnum
#   alias original_multiplication *
#   def *(other)
#     if (self == 6 && other == 9) || (self == 9 && other == 6) 
#         return 42
#       else  
#      original_multiplication(other)
#     end 
#    end
# end

# class Object

#   def swap_methods(method1, method2)
#     meth_1 = self.class.instance_method(method1.to_sym)
#     meth_2 = self.class.instance_method(method2.to_sym)
#     self.class.send(:define_method, method2.to_sym, meth_1)
#     self.class.send(:define_method, method1.to_sym, meth_2)
#    end
# end

# module Enumerable
#   def map_hash
#      Hash.new.tap do |hash|
#      each do |el|
#      pair = yield el
#      key = pair[0]
#      value = pair[1]
#      hash[key] = value
#        end
#      end
#   end
# end

# class Hash
#   # http://stackoverflow.com/questions/16159370/ruby-hash-default-value-behavior
#   def multi_invert
#     hash = Hash.new {|hash, key| hash[key] = [] }
#     each do |k, v|
#       # hash[v.to_sym] = [] 
#       hash[v] << k
#      end
#      hash
#   end
# end

# class Object
#   def expose_all
#     # http://stackoverflow.com/questions/7527832/ruby-dynamically-generate-attribute-accessor
#   self.instance_variables.each {|variable| 
#     name = variable.slice(1, variable.length)
#      # self.class.send(:attr_reader, name)
#      # p self.instance_eval "#{variable}"
#      self.send(:define_singleton_method, name) { self.instance_eval"#{variable}" }
#     }
#    end
# end

# class Cat
#   def initialize(color, whiskers)
#     @color = color
#     @whiskers = whiskers
#   end
# end

def test
  10.times do |i|
     p i
  end
end
  test 
# tom = Cat.new("black", "long")
# tom.expose_all
# p tom.whiskers
# p tom.color
# tom.instance_variable_get 
# hash = {"Coltrane" => "John", "Evans" => "Bill", "Gates" => "Bill"}
# p hash.multi_invert
# arr = ["Coltrane", "Vedder", "Evans"]
# p arr.map_hash {|name| [name, name.length]}
# text = "RubyLove"
# text.swap_methods(:upcase, :downcase)
# p text.downcase


# obj = Object.new
# p obj.class
# text = "RubyLove"
# p text.class
# p String.class
