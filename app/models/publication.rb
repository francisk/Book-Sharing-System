class Publication < ActiveRecord::Base
  attr_accessible :contributor, :cover, :isbn, :state, :title
  
  belongs_to :contributor, :class_name => "User", :foreign_key => "contributor"
end
