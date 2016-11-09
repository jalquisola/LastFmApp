class ArtistsController < ApplicationController
  before_action :set_pagination_params

  def show
    service = LastFmService.new

    api_response = service.get_top_artists_by_geo(params[:country], @page, @limit)
    if api_response.has_error?
      redirect_to root_url, alert: api_response.error_message
    else
      @artists = api_response.artists
      @paginatable_array = Kaminari.paginate_array(@artists,
                                                  total_count: api_response.total_count).
                                                  page(@page).
                                                  per(@limit)
    end
  end

  def tracks
    service = LastFmService.new

    @api_response = service.get_top_tracks_by_artist(params[:name],
                                                     params[:mbid],
                                                     @page,
                                                     @limit)
    if @api_response.keys.include?(:error)
      redirect_to root_url, alert: @api_response[:error]
    else
      @tracks = @api_response['toptracks']['track']
      @total_count = @api_response['toptracks']['@attr']['total'].to_i
      @paginatable_array = Kaminari.paginate_array(@tracks, total_count: @total_count).page(@page.to_i).per(@limit.to_i)
      puts @paginatable_array.inspect
    end
  end

  private

  def set_pagination_params
    @page  = params[:page].to_i < 1 ? 1 : params[:page].to_i
    @limit = params[:limit].to_i < 1 ? 5 : params[:limit].to_i
  end
end
