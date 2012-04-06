class Publication < ActiveRecord::Base
  # attr_accessible :contributor, :cover, :isbn, :state, :title, :author, :summary, :doubanURL
  attr_accessible :isbn, :location
  
  STATE_NOT_AUTH = 0
  STATE_IN = 1
  STATE_NOT_IN = 2
  
  def status
    if state == STATE_NOT_AUTH
      return "未审核"
    end
    if state == STATE_IN
      return "在馆"
    end
    if state == STATE_NOT_IN
      return "借出"
    end                       
  end
  
  def translators
    additional_attributes.find_all_by_name("translator")
  end
  
  def publisher
    additional_attributes.find_by_name("publisher").value
  end
  
  def pubdate
    additional_attributes.find_by_name("pubdate").value
  end
  
  def pages
    additional_attributes.find_by_name("pages").value
  end
  
  def price
    additional_attributes.find_by_name("price").value
  end
  
  def binding
    additional_attributes.find_by_name("binding").value
  end
  
  def count
    Publication.find_all_by_isbn(isbn).length
  end
  
  
  validates :isbn, :length => { :minimum => 10, :maximum => 13, },
                        :presence => true
  
  belongs_to :contributor, :class_name => "User", :foreign_key => "contributor_id"
  has_many :tags
  has_many :additional_attributes, :class_name => "Attribute", :foreign_key => "publication_id"
end
