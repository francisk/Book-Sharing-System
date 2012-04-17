class Order < ActiveRecord::Base
  attr_accessible :auditDate, :publication, :reader, :revertDate, :state
  
  STATE_BORROW_REQ = 1
  STATE_BORROW_AUDITED = 2
  STATE_REVERT_REQ = 3
  STATE_REVERT_AUDITED = 4
  STATE_CANCEL = 5
  
  
  belongs_to :publication, :class_name => "Publication", :foreign_key => "publication_id"
  belongs_to :reader, :class_name => "User", :foreign_key => "reader_id"
end
