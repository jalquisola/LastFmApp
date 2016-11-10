require 'rails_helper'

RSpec.describe Track, type: :model do
  subject do
    data = JSON.parse(File.read(Rails.root.join("spec", "fixtures", "track.json")))
    data["atattr"] = data.delete("@attr")

    Track.new(data)
  end

  describe "#new" do
    it "initializes name" do
      expect(subject.name).to eq "Believe"
    end

    it "initializes mbid" do
      expect(subject.mbid).to eq "32ca187e-ee25-4f18-b7d0-3b6713f24635"
    end

    it "initializes listeners" do
      expect(subject.listeners).to eq "390871"
    end

    it "initializes url" do
      expect(subject.url).to eq "https://www.last.fm/music/Cher/_/Believe"
    end

    it "initializes streamable" do
      expect(subject.streamable).to eq "0"
    end

    it "initializes artist" do
      expect(subject.artist.keys).to include("name", "mbid", "url")
    end

    it "initializes image" do
      expect(subject.image.size).to eq 4
    end

    it "initializes atattr" do
      expect(subject.atattr.keys).to include("rank")
    end
  end

  describe "#image_url" do
    context "when size param is nil" do
      it "returns nil" do
        expect(subject.image_url(nil)).to eq nil
      end
    end

    context "when size param is empty" do
      it "returns nil" do
        expect(subject.image_url('')).to eq nil
      end
    end

    context "when size param is invalid size" do
      it "returns nil" do
        expect(subject.image_url('test')).to eq nil
      end
    end

    context "when size param is small" do
      it "returns url" do
        expect(subject.image_url("small")).to eq "https://lastfm-img2.akamaized.net/i/u/34s/9895152d00b94fc9a0f92be6eec034cc.png"
      end
    end

    context "when size param is extralarge" do
      it "returns url" do
        expect(subject.image_url("extralarge")).to eq "https://lastfm-img2.akamaized.net/i/u/300x300/9895152d00b94fc9a0f92be6eec034cc.png"
      end
    end

    context "when image is empty" do
      subject{ Track.new(image: []) }

      context "when size param is valid" do
        it "returns nil" do
          expect(subject.image_url('small')).to eq nil
        end
      end
    end
  end

  describe "#rank" do
    context "when atattr attribute is missing" do
      it "returns nil" do
        expect(Track.new({}).rank).to eq nil
      end
    end

    context "when rank attribute is missing" do
      it "returns nil" do
        expect(Track.new({'atattr' => {}}).rank).to eq nil
      end
    end

    context "when rank attribute is valid" do
      it "returns 1" do
        expect(Track.new({'atattr' => {'rank' => '1'}}).rank).to eq '1'
      end
    end
  end
end
