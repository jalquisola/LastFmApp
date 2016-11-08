require 'rails_helper'

describe LastFmService do
  let(:resource){ LastFmService.new }

  describe '#new' do
    it "should have a base_url" do
      expect(resource.base_url).to eq("http://ws.audioscrobbler.com/2.0/")
    end
  end

  describe "#get_top_artists_by_geo" do
    context "when country param is nil" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo(nil)).to include(:error)
      end
    end

    context "when country param is blank" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('')).to include(:error)
      end
    end

    context "when page param is 0" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', 0)).to include(:error)
      end
    end

    context "when page param is -1" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', -1).keys).to include(:error)
      end
    end

    context "when limit param is 0" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', 1, 0).keys).to include(:error)
      end
    end

    context "when page param is -1" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', 1, -1).keys).to include(:error)
      end
    end

    context "when country param is SG" do
      subject(:api_response){resource.get_top_artists_by_geo('Singapore')}

      it "returns a hash with topartists key" do
        expect(api_response.keys).to include("topartists")
      end

      it "should have 5 artists" do
        expect(api_response["topartists"]["artist"].size).to eq 5
      end

      it "should contain country in the response" do
        expect(api_response["topartists"]["@attr"]).to include({"country"=>"Singapore", "perPage"=>"5"})
      end
    end

    context "when country param is United States, limit param is 10, and page param is 1" do
      subject(:api_response){resource.get_top_artists_by_geo('United States', 1, 10)}

      it "returns a hash with topartists key" do
        expect(api_response.keys).to include("topartists")
      end

      it "should have 10 artists" do
        expect(api_response["topartists"]["artist"].size).to eq 10
      end

      it "should contain country in the response" do
        expect(api_response["topartists"]["@attr"]).to include({"country"=>"United States", "perPage"=>"10"})
      end
    end

  end
end
