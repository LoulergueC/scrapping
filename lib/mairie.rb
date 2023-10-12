require 'rubygems'
require 'nokogiri'
require 'open-uri'

def do_scrappe url
    return Nokogiri::HTML(URI.open(url))
end

def get_townhall_email(townhall_url)
    
    # Remove the dot from ./95 and parse the url to the domain name
    transformed_url = "http://annuaire-des-mairies.com" + townhall_url[1..99999]
    
    html = do_scrappe(transformed_url)

    # Select the sibling next to the one containing 'Adresse Email'
    mail_xpath = html.xpath("//*[text()[contains(., 'Adresse Email')]]/following-sibling::td")

    return mail_xpath.text
end

# get_townhall_email('http://annuaire-des-mairies.com/95/ableiges.html')

def get_townhall_urls(directory_url)

    html = do_scrappe(directory_url)

    # Select the right table containing all the links and select every links inside it
    links_xpath = html.xpath("//table[@class = 'Style20']//a")
    
    return links_xpath
end

def get_directory(directory_url)

    directory = []

    # For each link, collect the townhall name, his href and with it, the email address
    get_townhall_urls(directory_url).map {|townhall|
        townhall_name = townhall.text()
        townhall_url = townhall["href"]
        townhall_email = get_townhall_email(townhall_url)

        # Put hash of every townhall into the array
        directory << {townhall_name => townhall_email}
    }

    puts directory
    return directory
end

get_directory("http://annuaire-des-mairies.com/val-d-oise.html")