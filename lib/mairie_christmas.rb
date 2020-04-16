require 'rubygems'
require 'nokogiri'
require 'open-uri'

def wait_message
    p "Voyons si, le temps que cela se charge, t'arrives à répondre à cette petite devinette"
    p "                       -----------------------------                            "
    p "Qu'est ce qui réfléchit sans réfléchir ?"                                                                      
end

#je récupère les noms des villes du 95
def city_name 
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    a_city_name = page.xpath('//*[@class="lientxt"]')
    all_cities_name = a_city_name.collect(&:text)
    return all_cities_name
end

def size
    all_cities_name = city_name
return  all_cities_name.size
end

# je récupère les urls des
def get_townhall_url (all_cities_name)
    all_cities_url = []
    all_cities_name.each do |name_city|
        url = "http://annuaire-des-mairies.com/95/#{name_city.downcase.gsub(" ","-")}.html"
        all_cities_url << url
    end
    return  all_cities_url
end

#jje recupere chaque email de chaque mairie à partir de l'url de chaque ville
def get_townhall_email (all_cities_url)
    all_emails_cities = []
    all_cities_url.each do |url|
        page = Nokogiri::HTML(open(url))
        email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
        all_emails_cities << email.text
    end
    return  all_emails_cities
end


#je met tous dans un hash nom zip email, puis boucle mettant dans un array l'union des deux
def union (all_cities_name, all_emails_cities)
    union = Hash[all_cities_name.zip(all_emails_cities)]
    union_array = []
    union.each do | k , v |
        union_array << {k.capitalize => v}
    end
    return union_array
end


#j'appelle toutes les méthodes
def perform
    wait_message
    all_cities_name = city_name()
    all_cities_url = get_townhall_url(all_cities_name)
    all_emails_cities = get_townhall_email(all_cities_url)
    union_array = union(all_cities_name, all_emails_cities)
    puts union_array
end



perform