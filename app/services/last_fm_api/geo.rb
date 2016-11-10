module LastFmApi
  class Geo < Base
    def initialize(country, page=1, limit=5)
      super()
      @country = country
      @limit   = limit
      @page    = page
    end

    def get_top_artists
      options = {
        api_key: ENV["LAST_FM_API_KEY"],
        method:  'geo.gettopartists',
        country: @country,
        limit:   @limit,
        page:    @page,
        format:  'json'
      }

      ApiResponse::GeoTopArtists.new(parsed_response( get(base_url, options)))
    end
  end
end
