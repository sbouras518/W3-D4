require 'rubygems'
require 'nokogiri'
require 'open-uri'

def wait_message
    p " occupe toi pendant au moins 5 bonnes petites minutes le temps que ça se charge ;)"
    p "ou si tu veux j'ai une devinette pour toi, qu'est qui peut retenir l'eau même si elle a des trous ??"
end
def get_urls(url)
  page = Nokogiri::HTML(open(url))
  page.xpath('//td/a/@href')
end

def get_email(url)
  page = Nokogiri::HTML(open(url))
  page.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li[1]/a').text
end

def perform
  domaine = "https://www.nosdeputes.fr"
  urls = get_urls("https://www.nosdeputes.fr/deputes")
  results = []

  urls.each do |e|
    a = e.to_s.rpartition('-')
    h = { "first_name" => a.first[1..-1], "last_name" => a.last, "email" => get_email(domaine + e) }
    results << h
  end

  puts results
end
wait_message
perform