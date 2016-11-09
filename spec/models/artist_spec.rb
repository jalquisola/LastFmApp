require 'rails_helper'

RSpec.describe Artist, type: :model do
  subject(:artist) do
    Artist.new(JSON.parse(File.read(Rails.root.join("spec", "fixtures", "artist.json"))))
  end

  describe "#new" do
    it "initializes name" do
      expect(subject.name).to eq "Coldplay"
    end

    it "initializes mbid" do
      expect(subject.mbid).to eq "cc197bad-dc9c-440d-a5b5-d52ba2e14234"
    end

    it "initializes listeners" do
      expect(subject.listeners).to eq "5131450"
    end

    it "initializes url" do
      expect(subject.url).to eq "https://www.last.fm/music/Coldplay"
    end

    it "initializes streamable" do
      expect(subject.streamable).to eq "0"
    end

    it "initializes image" do
      expect(subject.image.size).to eq 5
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
        expect(subject.image_url("small")).to eq "https://lastfm-img2.akamaized.net/i/u/34s/96caef91f25502d7cc5c9edb40a63494.png"
      end
    end

    context "when size param is mega" do
      it "returns url" do
        expect(subject.image_url("mega")).to eq "https://lastfm-img2.akamaized.net/i/u/96caef91f25502d7cc5c9edb40a63494.png"
      end
    end

    context "when image is empty" do
      subject(:artist){ Artist.new(image: []) }

      context "when size param is valid" do
        it "returns nil" do
          expect(subject.image_url('small')).to eq nil
        end
      end
    end
  end
end
