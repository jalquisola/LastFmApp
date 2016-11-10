module ApiResponse
  class ArtistTopTracks < Base
    def initialize(data)
      super(data, "toptracks")
      @top_tracks = data.try(:[], "toptracks")
    end

    def tracks
      #There is bug in Last.FM API Response, it returns more items than specified limit.
      #Thus, we get the first n elements of the array based on per_page.
      Array(@top_tracks.try(:[], 'track')).first(per_page).map do |track|
        track["atattr"] = track.delete("@attr")
        Track.new(track)
      end
    end
  end
end
