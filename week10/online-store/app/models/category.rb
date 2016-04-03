class Category < ActiveRecord::Base
  belongs_to :brand, index: true
  has_many :products
end