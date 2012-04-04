require 'net/http'
require 'json'

class DoubanApi
  @@apikey = "0151de22e015f5a903f59a68a041e0fb"
  
  def DoubanApi.queryWithHTTP(isbn)
    url = URI.parse('http://api.douban.com/book/subject/isbn/' + isbn)
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Get.new(url.path + "?apikey=" + @@apikey + "&alt=json")
      puts http.request(req).body
    end
  end
  
  def DoubanApi.queryBookInfo(isbn)
    obj = JSON.parse DoubanApi.queryWithHTTP(isbn)
    puts "---------------x-------------------"
  end
end
