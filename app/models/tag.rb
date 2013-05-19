# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  attr_accessible :name, :publication
  
  belongs_to :publication
end
