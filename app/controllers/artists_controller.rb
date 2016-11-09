class ArtistsController < ApplicationController
  def show
    service = LastFmService.new
    @page = params[:page]   || 1
    @limit = params[:limit] || 5

    @api_response = service.get_top_artists_by_geo(params[:country], @page.to_i, @limit.to_i)
    @artists = @api_response['topartists']['artist']
  end
end
