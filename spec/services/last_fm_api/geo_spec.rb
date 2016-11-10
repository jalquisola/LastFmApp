require 'rails_helper'

describe LastFmApi::Geo do
  let(:resource){ LastFmApi::Geo }

  describe "#get_top_artists" do
    context "when country param is nil" do
      subject{ resource.new(nil).get_top_artists }

      it "returns an instance of ApiResponse::GeoTopArtists" do
        expect(subject).to be_an_instance_of(ApiResponse::GeoTopArtists)
      end

      it "returns a hash with error" do
        expect(subject.has_error?).to eq true
      end
    end

    context "when country param is blank" do
      it "returns a hash with error" do
        expect(resource.new('').get_top_artists.has_error?).to eq true
      end
    end

    context "when page param is 0" do
      it "returns a hash with error" do
        expect(resource.new('Singapore', 0).get_top_artists.has_error?).to eq true
      end
    end

    context "when page param is -1" do
      it "returns a hash with error" do
        expect(resource.new('Singapore', -1).get_top_artists.has_error?).to eq true
      end
    end

    context "when limit param is 0" do
      it "returns a hash with error" do
        expect(resource.new('Singapore', 1, 0).get_top_artists.has_error?).to eq true
      end
    end

    context "when page param is -1" do
      it "returns a hash with error" do
        expect(resource.new('Singapore', 1, -1).get_top_artists.has_error?).to eq true
      end
    end

    context "when country param is SG" do
      subject(:api_response){resource.new('Singapore').get_top_artists}

      it "returns an instance of ApiResponse::GeoTopArtists" do
        expect(api_response).to be_an_instance_of(ApiResponse::GeoTopArtists)
      end

      it "should have 5 artists" do
        expect(api_response.artists.size).to eq 5
      end
    end
  end
end
