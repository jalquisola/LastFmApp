require 'rails_helper'

RSpec.describe ApiResponse::GeoTopArtists, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  subject{ ApiResponse::GeoTopArtists(para) }
  let(:resource){ ApiResponse::GeoTopArtists }
  describe "#new" do
    context "when attributes are nil" do
      it "raise an error" do
        expect{resource.new(nil)}.to raise_error(ArgumentError)
      end
    end

    context "when attributes are empty hash" do
      it "instantiate resource" do
        expect(resource.new({})).to be_an_instance_of(ApiResponse::GeoTopArtists)
      end
    end
  end

  describe "#artists" do
    context "when topartists field is empty hash" do
      it "returns empty array" do
        expect(resource.new({'topartists' => {} }).artists).to eq []
      end
    end

    context "when topartists field is not empty but artist field is empty" do
      it "returns empty array" do
        expect(resource.new({'topartists' => { 'artist' => []}}).artists).to eq []
      end
    end

    context "when topartists field contain artist data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "geo_top_artist.json")))
        resource.new(data)
      end

      it "returns array of artists with size 2" do
        expect(subject.artists.size).to eq 2
      end

      it "returns array of Artist instance" do
        expect(subject.artists.first).to be_an_instance_of(Artist)
      end
    end
  end

  describe "#total_count" do
    context "when topartists field is empty hash" do
      it "returns 0" do
        expect(resource.new({'topartists' => {} }).total_count).to eq 0
      end
    end

    context "when topartists field is not empty but @attr field is empty" do
      it "returns 0" do
        expect(resource.new({'topartists' => { '@attr' => {}}}).total_count).to eq 0
      end
    end

    context "when topartists field contain artist data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "geo_top_artist.json")))
        resource.new(data)
      end

      it "returns integer, 125297" do
        expect(subject.total_count).to eq 125297
      end
    end
  end

  describe "#has_error?" do
    context "when topartists field contain artist data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "geo_top_artist.json")))
        resource.new(data)
      end

      it "returns false" do
        expect(subject.has_error?).to eq false
      end
    end

    context "when there are errors" do
      it "returns true" do
        data = JSON.parse('{"error":6,"message":"country param invalid","links":[]}')
        expect(resource.new(data).has_error?).to eq true
      end
    end
  end

  describe "#error_message" do
    context "when topartists field contain artist data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "geo_top_artist.json")))
        resource.new(data)
      end

      it "returns false" do
        expect(subject.error_message).to eq ""
      end
    end

    context "when there are errors" do
      it "returns country param invalid" do
        data = JSON.parse('{"error":6,"message":"country param invalid","links":[]}')
        expect(resource.new(data).error_message).to eq "country param invalid"
      end
    end
  end

end
