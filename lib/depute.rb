require 'rubygems'
require 'nokogiri'
require 'open-uri'

def do_scrappe url
    return Nokogiri::HTML(URI.open(url))
end

def get_deputy_infos(deputy_profile_url)
    
    # Remove the dot from ./95 and parse the url to the domain name
    # transformed_url = "http://annuaire-des-mairies.com" + townhall_url[1..99999]
    
    html = do_scrappe(deputy_profile_url)

    # Select the email address on info page
    mail_xpath = html.xpath("//*[@id='main']/div/div/div/section[2]/div/ul/li[1]/a/span[2]").text

    # Select the full name on info page e.g. M. Ugo Bernalicis
    name_xpath = html.xpath('//*[@id="main"]/div/div/div/section[1]/div/div[1]/h1').text

    # Select the first name by spliting full name and selecting the second one (not M. or Mme)
    first_name = name_xpath.split(' ')[1]

    # Select the name by substracting Mme, M. and the first name from the full name
    last_name = name_xpath.gsub('Mme ', '').gsub('M. ', '').gsub(first_name + ' ', '')

    info_hash = {
        "first_name" => first_name,
        "last_name" => last_name,
        "email" => mail_xpath
    }
    puts info_hash
    return info_hash
end

# get_deputy_infos('https://www.assemblee-nationale.fr/dyn/deputes/PA605036')
# get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA794138')
# get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA718838')
# get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA267042')
# get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA722366')
# get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA721296')

def get_deputy_url

    html = do_scrappe("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique")

    # All the links of the deputy members
    href_xpath = html.xpath('//*[@id="deputes-list"]//li/a')

    directory = []
    href_xpath.map { |href|
        fixed_url = "https://www2.assemblee-nationale.fr" + href["href"]
        directory << get_deputy_infos(fixed_url)
    }

    puts directory
    return directory
end

# The list is too long and the request is timed out when scrapping
get_deputy_url