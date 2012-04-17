class Publication < ActiveRecord::Base
  attr_accessible :contributor, :cover, :isbn, :state, :title, :summary, :doubanURL, :location

  STATE = ["未审核", "在馆", "借出"]
  
  STATE_NOT_AUTH = 0
  STATE_IN = 1
  STATE_NOT_IN = 2
  
  def status
    STATE[state]
  end
  
  def getAttr(attrName)
    attribute = additional_attributes.find_by_name(attrName)
    return attribute.value unless attribute.nil?
  end
  
  def author_intro
    getAttr("author-intro")
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
    additional_attributes.find_all_by_name("translator").map  { |translator| translator.value }.join("　")
  end
    
  def authors
    additional_attributes.find_all_by_name("author").map { |author| author.value }.join("　")
  end
  
  def count
    Publication.find_all_by_isbn(isbn).length
  end
  
  def publications
    Publication.group(:contributor_id).find_all_by_isbn(isbn)
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
