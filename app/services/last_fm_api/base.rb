module LastFmApi
  class Base
    attr_reader :base_url

    def initialize
      @base_url = ENV["LAST_FM_API_URL"]
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
end
