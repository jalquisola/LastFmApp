require 'rails_helper'

RSpec.describe ApiResponse::ArtistTopTracks, type: :model do
  let(:resource){ ApiResponse::ArtistTopTracks }

  describe "#new" do
    context "when attributes are nil" do
      it "raise an error" do
        expect{resource.new(nil)}.to raise_error(ArgumentError)
      end
    end

    context "when attributes are empty hash" do
      it "instantiate resource" do
        expect(resource.new({})).to be_an_instance_of(ApiResponse::ArtistTopTracks)
      end
    end
  end

  describe "#tracks" do
    context "when toptracks field is empty hash" do
      it "returns empty array" do
        expect(resource.new({'toptracks' => {} }).tracks).to eq []
      end
    end

    context "when toptracks field is not empty but track field is empty" do
      it "returns empty array" do
        expect(resource.new({'toptracks' => { "track" => []}}).tracks).to eq []
      end
    end

    context "when toptracks field contain tracks data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "artist_top_tracks.json")))
        resource.new(data)
      end

      it "returns array of tracks with size 2" do
        expect(subject.tracks.size).to eq 2
      end

      it "returns array of Track instance" do
        expect(subject.tracks.first).to be_an_instance_of(Track)
      end
    end
  end

  describe "#total_count" do
    context "when toptracks field is empty hash" do
      it "returns 0" do
        expect(resource.new({'toptracks' => {} }).total_count).to eq 0
      end
    end

    context "when toptracks field is not empty but @attr field is empty" do
      it "returns 0" do
        expect(resource.new({'toptracks' => { '@attr' => {}}}).total_count).to eq 0
      end
    end

    context "when toptracks field contain track data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "artist_top_tracks.json")))
        resource.new(data)
      end

      it "returns integer, 30818" do
        expect(subject.total_count).to eq 30818
      end
    end
  end

  describe "#has_error?" do
    context "when toptracks field contain track data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "artist_top_tracks.json")))
        resource.new(data)
      end

      it "returns false" do
        expect(subject.has_error?).to eq false
      end
    end

    context "when there are errors" do
      it "returns true" do
        data = JSON.parse('{"error":6,"message":"artists param invalid","links":[]}')
        expect(resource.new(data).has_error?).to eq true
      end
    end
  end

  describe "#error_message" do
    context "when toptracks field contain tracks data" do
      subject do
        data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "artist_top_tracks.json")))
        resource.new(data)
      end

      it "returns false" do
        expect(subject.error_message).to eq ""
      end
    end

    context "when there are errors" do
      it "returns country param invalid" do
        data = JSON.parse('{"error":6,"message":"artist param invalid","links":[]}')
        expect(resource.new(data).error_message).to eq "artist param invalid"
      end
    end
  end
end
