require 'rest-client'

class LastFmService
  attr_reader :base_url

  def initialize
    @base_url = ENV["LAST_FM_API_URL"]
  end

  def get_top_artists_by_geo(country, page=1, limit=5)
    return {error: "Country param invalid."} if country.blank?
    return {error: "Page param should be 1-1000000."} if page < 1
    return {error: "Limit param should be 1-1000."} if limit < 1

    options = {
      api_key: ENV["LAST_FM_API_KEY"],
      method:  'geo.gettopartists',
      country: country,
      limit:   limit,
      page:    page,
      format:  'json'
    }

    parsed_response(RestClient.get(base_url, params: options ))
  end

  private

  def parsed_response(resp)
    resp.code.to_i == 200 ? JSON.parse(resp.body) : nil
  end

end
