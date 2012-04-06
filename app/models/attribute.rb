class Attribute < ActiveRecord::Base
  attr_accessible :name, :publication, :value
  belongs_to :publication, :class_name => "Publication", :foreign_key => "publication"
end
