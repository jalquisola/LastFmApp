require 'rest-client'

class LastFmService
  attr_reader :base_url

  def initialize
    @base_url = ENV["LAST_FM_API_URL"]
  end

  def get_top_artists_by_geo(country, page=1, limit=5)
    options = {
      api_key: ENV["LAST_FM_API_KEY"],
      method:  'geo.gettopartists',
      country: country,
      limit:   limit,
      page:    page,
      format:  'json'
    }

    ApiResponse::GeoTopArtists.new(parsed_response( get(base_url, options)))
  end

  def get_top_tracks_by_artist(artist, mbid=nil, page=1, limit=5)
    options = {
      api_key: ENV["LAST_FM_API_KEY"],
      method:  'artist.gettoptracks',
      autocorrect: 1,
      artist: artist,
      limit:   limit,
      page:    page,
      format:  'json'
    }

    options[:mbid] = mbid if mbid.present?

    ApiResponse::ArtistTopTracks.new(parsed_response( get(base_url, options)))
  end

  private

  def get(base_url, options)
    begin
      RestClient.get(base_url, params: options )
    rescue => e
      {error: e.message}
    end
  end

  def parsed_response(resp)
    resp.code.to_i == 200 ? JSON.parse(resp.body) : nil
  end

end
