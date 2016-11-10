module ApiResponse
  class GeoTopArtists < Base
    def initialize(data)
      super(data, "topartists")
      @top_artists = data.try(:[], "topartists")
    end

    def artists
      #There is bug in Last.FM API Response, it returns more items than specified limit.
      #Thus, we get the first n elements of the array based on per_page.
      Array(@top_artists.try(:[], "artist")).first(per_page).map{|artist| Artist.new(artist)}
    end
  end
end
