class Artist
  include ActiveModel::Model
  attr_accessor :name, :mbid, :url, :image, :listeners, :streamable

  def image_url(size="medium")
    image.select{|img| img.try(:[], "size") == size}.try(:first).try(:[], "#text")
  end
end
