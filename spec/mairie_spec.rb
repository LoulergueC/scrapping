require_relative('../lib/mairie')

describe "get_townhall_email" do
    it "should return a string" do
      expect( get_townhall_email("./95/le-thillay.html").class ).to eq(String)
    end
    it "should not return an empty result" do
        expect( get_townhall_email("./95/chars.html").empty? ).to eq(false)
    end
    it "should return an email address" do
      expect( get_townhall_email("./95/marines.html") ).to eq("mairie.marines@wanadoo.fr")
    end
end

get_directory_result = get_directory("http://annuaire-des-mairies.com/val-d-oise.html")

describe "get_directory" do
    it "should return an array" do
      expect( get_directory_result.class ).to eq(Array)
    end
    it "should not return an empty result" do
        expect( get_directory_result.empty? ).to eq(false)
    end
    it "should at least contain LASSY" do
      expect( get_directory_result.map{|h| h.has_key?('LASSY')}.include?(true) ).to eq(true)
    end
end