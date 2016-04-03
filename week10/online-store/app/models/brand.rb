class Brand < ActiveRecord::Base
  has_many :categories
  has_many :products, through: :categories    
end