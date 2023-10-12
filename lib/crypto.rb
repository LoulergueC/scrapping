require 'rubygems'
require 'nokogiri'
require 'open-uri'

def crypto_scrappe 

    url = "https://coinmarketcap.com/all/views/all/"
    page = Nokogiri::HTML(URI.open(url))

    crypto = page.xpath("//tbody/*/td[3]/div")
    currency = page.xpath("//tbody/*/td[5]")

    output = []

    crypto.each_with_index do |c,index|
        output << { crypto[index].text => currency[index].text.gsub("$", "").to_f }
    end

    return output

end

# puts crypto_scrappe.map{|h| h.has_key?('BTC')}.include?(true)