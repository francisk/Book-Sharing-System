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
  
  def getAttr(attrName)
    additional_attributes.find_by_name(attrName).value
  end
  
  def publisher
    getAttr("publisher")
  end
  
  def pubdate
    getAttr("pubdate")
  end
  
  def pages
    getAttr("pages")
  end
  
  def price
    getAttr("price")
  end
  
  def binding
    getAttr("binding")
  end
  
  def translators
    additional_attributes.find_all_by_name("translator")
  end
    
  def count
    Publication.find_all_by_isbn(isbn).length
  end
  
  
  validates :isbn, :length => { :minimum => 10, :maximum => 13, },
                        :presence => true
  
  belongs_to :contributor, :class_name => "User", :foreign_key => "contributor_id"
  has_many :tags, :dependent => :destroy
  has_many :additional_attributes, 
                  :class_name => "Attribute", 
                  :foreign_key => "publication_id",
                  :dependent => :destroy
end
