module ApiResponse
  class ArtistTopTracks

    def initialize(data)
      raise ArgumentError.new("data is invalid") unless data

      @data = data
      @top_tracks = data.try(:[], "toptracks")
    end

    def tracks
      Array(@top_tracks.try(:[], 'track')).map do |track|
        track["atattr"] = track.delete("@attr")
        Track.new(track)
      end
    end

    def total_count
      @top_tracks.try(:[], '@attr').try(:[], 'total').to_i
    end

    def has_error?
      @data.try(:[], "error").present?
    end

    def error_message
      has_error? ? @data.try(:[], "message") : ""
    end
  end
end
