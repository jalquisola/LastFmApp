module LastFmApi
  class Artist < Base
    def initialize(artist, mbid=nil, page=1, limit=5)
      super()
      @artist = artist
      @mbid   = mbid
      @limit  = limit
      @page   = page
    end

    def get_top_tracks
      options = {
        api_key:     ENV["LAST_FM_API_KEY"],
        method:      'artist.gettoptracks',
        artist:      @artist,
        limit:       @limit,
        page:        @page,
        autocorrect: 1,
        format:      'json'
      }

      options[:mbid] = @mbid if @mbid.present?

      ApiResponse::ArtistTopTracks.new(parsed_response( get(base_url, options)))
    end
  end
end
