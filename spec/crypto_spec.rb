require_relative('../lib/crypto')

describe "Nokogiri scrap" do
    it "should return an array" do
      expect( crypto_scrappe.class ).to eq(Array)
    end
    
    it "should not be empty" do
      expect( crypto_scrappe.empty? ).to eq(false)
    end

    it "should at least have BTC" do
        expect( crypto_scrappe.map{|h| h.has_key?('BTC')}.include?(true) ).to eq(true)
    end

    it "should at least have ETH" do
        expect( crypto_scrappe.map{|h| h.has_key?('ETH')}.include?(true) ).to eq(true)
    end
    
    it "should at least have DOGE" do
        expect( crypto_scrappe.map{|h| h.has_key?('DOGE')}.include?(true) ).to eq(true)
    end
end