class ArtistsController < ApplicationController
  before_action :set_pagination_params

  def show
    api_response = LastFmApi::Geo.new(params[:country], @page, @limit).get_top_artists

    if api_response.has_error?
      redirect_to root_url, alert: api_response.error_message
    else
      @artists = api_response.artists
      set_paginatable_array(@artists, api_response.total_count)
    end
  end

  def tracks
    api_response = LastFmApi::Artist.new( params[:name],
                                          params[:mbid],
                                          @page,
                                          @limit).get_top_tracks
    if api_response.has_error?
      redirect_to root_url, alert: @api_response[:error]
    else
      @tracks = api_response.tracks
      set_paginatable_array(@tracks, api_response.total_count)
    end
  end

  private

  def set_pagination_params
    @page  = params[:page].to_i < 1 ? 1 : params[:page].to_i
    @limit = params[:limit].to_i < 1 ? 5 : params[:limit].to_i
  end

  def set_paginatable_array(data, total)
    @paginatable_array = Kaminari.paginate_array(data, total_count: total).page(@page).per(@limit)
  end
end
