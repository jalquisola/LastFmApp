require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, country: "Singapore"
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, country: "Singapore"
      expect(response).to render_template("show")
    end
  end

  describe "GET #tracks" do
    it "responds successfully with an HTTP 200 status code" do
      get :tracks, name: "Adele"
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :tracks, name: "Adele"
      expect(response).to render_template("tracks")
    end
  end

end
