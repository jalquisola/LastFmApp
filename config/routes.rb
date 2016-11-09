Rails.application.routes.draw do
  root "pages#home"
  get "/artists/:country", to: "artists#show", as: :artists
  get "/artists/:name/tracks", to: "artists#tracks", as: :artist_tracks
end
