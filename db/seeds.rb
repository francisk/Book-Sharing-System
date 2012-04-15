# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Publication.delete_all
(0..100).each do |i|
  book = Publication.create :cover => 'http://img1.douban.com/spic/s2144391.jpg', :state => Publication::STATE_NOT_AUTH,
  :title => "少有人走的路#{i}", :isbn => '90011122233', :author => 'James Gosling', :summary => "fdkjfkdkfjkskjfjksjdfjsjdfskdjfksdf",
  :doubanURL => 'http://book.douban.com', :contributor => User.first
  
  book.additional_attributes.create :name => "translator", :value => "Li Lei" 
  book.additional_attributes.create :name => "publisher", :value => "中国华侨出版社"
  book.additional_attributes.create :name => "pubdate", :value => "2012-04"
  book.additional_attributes.create :name => "price", :value => "12.34"
  book.additional_attributes.create :name => "binding", :value => "平装"
end