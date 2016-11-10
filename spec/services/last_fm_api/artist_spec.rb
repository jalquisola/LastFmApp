require 'rails_helper'

describe LastFmApi::Artist do
  let(:resource){ LastFmApi::Artist }

  describe "#get_top_tracks" do
    context "when artist param is nil" do
      subject{ resource.new(nil).get_top_tracks }

      it "returns ApiResponse::ArtistTopTracks instance" do
        expect(subject).to be_an_instance_of(ApiResponse::ArtistTopTracks)
      end

      it "should have an error" do
        expect(subject.has_error?).to eq true
      end
    end

    context "when artist param is empty string" do
      subject{ resource.new('').get_top_tracks }

      it "returns ApiResponse::ArtistTopTracks instance" do
        expect(subject).to be_an_instance_of(ApiResponse::ArtistTopTracks)
      end

      it "should have an error" do
        expect(subject.has_error?).to eq true
      end
    end

    context "when page param is 0" do
      #this is endpoint is very weird, 0 page param will be set to default page that is 1
      subject{ resource.new('Adele', nil, 0).get_top_tracks }

      it "returns no error" do
        expect(subject.has_error?).to eq false
      end

      it "returns 5 tracks" do
        expect(subject.tracks.size).to eq 5
      end
    end

    context "when page param is -1" do
      #this is endpoint is very weird, negative page param will be set to default page that is 1
      subject{ resource.new('Adele', nil, -1).get_top_tracks }

      it "returns no error" do
        expect(subject.has_error?).to eq false
      end

      it "returns 5 tracks" do
        expect(subject.tracks.size).to eq 5
      end
    end

    context "when limit param is 0" do
      #this is endpoint is very weird, limit param will be set to default limit that is 50
      subject{ resource.new('Adele', nil, -1, 0).get_top_tracks }

      it "returns no error" do
        expect(subject.has_error?).to eq false
      end

      it "returns 50 tracks" do
        expect(subject.tracks.size).to eq 50
      end
    end

    context "when limit param is -1" do
      #this is endpoint is very weird, negative limit params will be set to default limit that is 50
      subject{ resource.new('Adele', nil, -1, -1).get_top_tracks }

      it "returns no error" do
        expect(subject.has_error?).to eq false
      end

      it "returns 50 tracks" do
        expect(subject.tracks.size).to eq 50
      end
    end

    context "when artist param is valid" do
      context "when limit is nil" do
        subject(:api_response){resource.new("Adele").get_top_tracks}

        it "returns an instance of ApiResponse::ArtistTopTracks" do
          expect(api_response).to be_an_instance_of(ApiResponse::ArtistTopTracks)
        end

        it "returns 5 tracks" do
          expect(api_response.tracks.size).to eq 5
        end
      end

      context "when limit is 10" do
        subject(:api_response){resource.new('Adele', nil, 1, 10).get_top_tracks}

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
