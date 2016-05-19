class Post < ActiveRecord::Base
   # attr_accessible :name, :content
  validates :name, :content, :presence => true
  validates :name, :length => { :minimum => 2 }
  validates :name, :uniqueness => { :message => "already taken" }
end

