module ApiResponse
  class GeoTopArtists
    attr_reader :top_artists

    def initialize(data)
      raise ArgumentError.new("data params should not be nil") unless data

      @data = data
      @top_artists = data.try(:[], "topartists")
    end

    def artists
      Array(@top_artists.try(:[], 'artist')).map{|artist| Artist.new(artist)}
    end

    def total_count
      @top_artists.try(:[], '@attr').try(:[], 'total').to_i
    end

    def has_error?
      @data.try(:[], "error").present?
    end

    def error_message
      has_error? ? @data.try(:[], "message") : ""
    end
  end
end
