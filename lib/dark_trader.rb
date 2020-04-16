require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

# méthode qui retourne un tableau la valeur de chaque cryptomonnaies
def crypto_value(page)
  price = []
  page.xpath('//tr/td[5]/a').each do |value|
    price << value.text.delete('$,').to_f
  end
  return  price
end

# méthode qui retourne un tableau le symbole de chaque cryptomonnaies
def crypto_name(page)
  name = []
  page.xpath('//tr/td[3]/div').each do |symbol|
  name << symbol.text
  end
  return name
end

# méthode qui retourne le tout dans un hash
def my_hash(name, price)
  hash = Hash.new
  array = []
  hash = name.zip(price)
  hash.each do |h|
  array << {h[0] => h[1]}
   end
   return p array
end

# méthode qui appelle toutes les méthodes
def perform(page)
  price = crypto_value(page)
  name = crypto_name(page)
  my_hash(name, price)
end

perform(page)
