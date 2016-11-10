class Track
  include ActiveModel::Model
  attr_accessor :name, :playcount, :mbid, :url, :image,
                :listeners, :streamable, :artist, :atattr

  def image_url(size="medium")
    self.image.select{|img| img.try(:[], "size") == size}.try(:first).try(:[], "#text")
  end

  def rank
    atattr.try(:[], "rank")
  end
end
