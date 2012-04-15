User.delete_all
(0..10).each do |i|
  User.create :itcode => "lixb#{i}", :name => "李小波#{i}", :phone => "82707961", :email => "lixb#{i}@digitalchina.com"
end