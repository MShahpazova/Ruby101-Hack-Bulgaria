class Photo < ActiveRecord::Base
  validates :name, :url, :presence => true
end
