require 'nokogiri'
require 'open-uri'


#  Function to retrieve e-mail addresses of French MPs

def get_depute_infos(url)
  doc = Nokogiri::HTML(open(url))

  email = doc.xpath('/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  full_name = doc.xpath('/html/body/div/div[3]/div/div/div/section[1]/div/article/div[2]/h1').text.split(" ")
  first_name = full_name[1]
  last_name = full_name[2..-1].join(" ") 

 return {
   "first_name" => first_name,
   "last_name" => last_name,
   "email" => email
 }
end

# Function to have the final result

def get_depute_urls
  list_url_depute = 'http://www.assemblee-nationale.fr/qui/xml/regions.asp?legislature=14'
  result_array = []

  doc = Nokogiri::HTML(open(list_url_depute))

  #allows to test the program without planting it
  doc.xpath('//*[@class="dep2"]/@href').to_a.sample(10).each do |url|
    full_url_depute = "http://www.assemblee-nationale.fr#{url}"

    #Exception and rescuing
    begin
      depute_infos = get_depute_infos(full_url_depute)
      result_array << depute_infos
    rescue => e
      puts "Not Found : #{full_url_depute}"
    end

  end
  return result_array
end


#.inspect allows to see the table
puts get_depute_urls.inspect 