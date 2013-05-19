# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

User.delete_all
User.create :name => '韩寒', :email => 'admin@hanhan.com', :phone => '13300000001', :itcode => 'hanhan'
User.create :name => '老罗', :email => 'laoluo@chuizi.com', :phone => '13300000002', :itcode => 'laoluo'
User.create :name => '雷布斯', :email => 'leibusi@xiaomi.com', :phone => '13300000003', :itcode => 'leibusi'

Publication.delete_all
(0..100).each do |i|
  book = Publication.create :cover => 'http://img1.douban.com/spic/s2144391.jpg', :state => Publication::STATE_NOT_AUTH,
  :title => "少有人走的路#{i}", :isbn => '90011122233', :summary => "fdkjfkdkfjkskjfjksjdfjsjdfskdjfksdf",
  :doubanURL => 'http://book.douban.com', :contributor => i % 2 == 0 ? User.first : User.last
  
  book.additional_attributes.create :name => "author", :value => "Han Meimei" 
  book.additional_attributes.create :name => "translator", :value => "Li Lei" 
  book.additional_attributes.create :name => "publisher", :value => "中国华侨出版社"
  book.additional_attributes.create :name => "pubdate", :value => "2012-04"
  book.additional_attributes.create :name => "price", :value => "12.34"
  book.additional_attributes.create :name => "binding", :value => "平装"
end
