class Product < ActiveRecord::Base
  belongs_to :category, index: true
end