class String
  def blank?
    (/\s+/ =~ self) == 0 
  end
end

# class Hash
#   def blank?
#     self == {}
#   end
# end

# class Array
# def blank?
#    self == []
#  end 
# end

class Object

  def blank?
    self == nil || self.empty?
  end

  def present?
    self.blank? == false
  end

  def presence?
    self.present? ? self : nil
  end

  def try(method_name, &block)
   self == nil || !self.respond_to?(method_name, &block) ? nil : self.send(method_name, &block)
  end

end

class String
  def inquiry
    StringInquirer.new(self)
  end
end

class StringInquirer
  def initialize(target_obj)
    @target_obj = target_obj
  end

  def method_missing(method_name, *args, &block)
    @target_obj.respond_to?(method_name, *args, &block) ? @target_obj.send(method_name, *args, &block) : is_equal(method_name)
  end

  def is_equal(str)
    @target_obj.eql?(str.to_s.chop)
  end

end

 p "active".inquiry.inactive?
# obj = nil
# puts obj.blank?

# test_str = StringInquirer.new("loveRuby")
# p test_str.loveRubys?
# num = 8
# str = []
# p str.try(:next)
# puts num.try(:next)
# arr = [5,4,6,3]
# p arr.presence?
# arr = []
# puts arr.blank?

# hash = {}
# puts hash.blank?
# str = String.new("    ")
# puts str.blank?
