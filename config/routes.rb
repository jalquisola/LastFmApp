Rails.application.routes.draw do
  root "pages#home"
  get "/artists/:country", to: "artists#show", as: :artists
end
