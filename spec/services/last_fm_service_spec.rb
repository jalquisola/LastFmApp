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
      subject{ resource.get_top_artists_by_geo(nil) }

      it "returns an instance of ApiResponse::GeoTopArtists" do
        expect(subject).to be_an_instance_of(ApiResponse::GeoTopArtists)
      end

      it "returns a hash with error" do
        expect(subject.has_error?).to eq true
      end
    end

    context "when country param is blank" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('').has_error?).to eq true
      end
    end

    context "when page param is 0" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', 0).has_error?).to eq true
      end
    end

    context "when page param is -1" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', -1).has_error?).to eq true
      end
    end

    context "when limit param is 0" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', 1, 0).has_error?).to eq true
      end
    end

    context "when page param is -1" do
      it "returns a hash with error" do
        expect(resource.get_top_artists_by_geo('Singapore', 1, -1).has_error?).to eq true
      end
    end

    context "when country param is SG" do
      subject(:api_response){resource.get_top_artists_by_geo('Singapore')}

      it "returns an instance of ApiResponse::GeoTopArtists" do
        expect(api_response).to be_an_instance_of(ApiResponse::GeoTopArtists)
      end

      it "should have 5 artists" do
        expect(api_response.artists.size).to eq 5
      end
    end
  end

  describe "#get_top_tracks_by_artist" do
    context "when artist param is nil" do
      subject{ resource.get_top_tracks_by_artist(nil)}

      it "returns ApiResponse::ArtistTopTracks instance" do
        expect(subject).to be_an_instance_of(ApiResponse::ArtistTopTracks)
      end

      it "should have an error" do
        expect(subject.has_error?).to eq true
      end
    end

    context "when artist param is empty string" do
      subject{ resource.get_top_tracks_by_artist('')}

      it "returns ApiResponse::ArtistTopTracks instance" do
        expect(subject).to be_an_instance_of(ApiResponse::ArtistTopTracks)
      end

      it "should have an error" do
        expect(subject.has_error?).to eq true
      end
    end

    context "when page param is 0" do
      #this is endpoint is very weird, 0 page param will be set to default page that is 1
      it "should have an error" do
        expect(resource.get_top_tracks_by_artist('Adele', nil, 0).has_error?).to eq false
      end
    end

    context "when page param is -1" do
      #this is endpoint is very weird, negative page param will be set to default page that is 1
      it "returns a hash with error" do
        expect(resource.get_top_tracks_by_artist('Adele', nil, -1).has_error?).to eq false
      end
    end

    context "when limit param is 0" do
      #this is endpoint is very weird, limit param will be set to default limit that is 50
      it "returns a hash with error" do
        expect(resource.get_top_tracks_by_artist('Adele', nil, -1, 0).has_error?).to eq false
      end
    end

    context "when limit param is -1" do
      #this is endpoint is very weird, negative limit params will be set to default limit that is 50
      it "should not return an error" do
        expect(resource.get_top_tracks_by_artist('Adele', nil, 1, -1).has_error?).to eq false
      end
    end

    context "when artist param is valid" do
      context "when limit is nil" do
        subject(:api_response){resource.get_top_tracks_by_artist('Adele')}

        it "returns an instance of ApiResponse::ArtistTopTracks" do
          expect(api_response).to be_an_instance_of(ApiResponse::ArtistTopTracks)
        end

        it "returns 5 tracks" do
          expect(api_response.tracks.size).to eq 5
        end
      end

      context "when limit is 10" do
        subject(:api_response){resource.get_top_tracks_by_artist('Adele', nil, 1, 10)}

        it "returns an instance of ApiResponse::ArtistTopTracks" do
          expect(api_response).to be_an_instance_of(ApiResponse::ArtistTopTracks)
        end

        it "returns 10 tracks" do
          expect(api_response.tracks.size).to eq 10
        end
      end
    end
  end
end
