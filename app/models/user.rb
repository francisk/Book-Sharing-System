class User < ActiveRecord::Base
  attr_accessible :email, :itcode, :name, :phone
  
  has_many :publications, :class_name => "Publication", :foreign_key => "contributor"
end
