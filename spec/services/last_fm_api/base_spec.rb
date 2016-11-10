require 'rails_helper'

describe LastFmApi::Base do
  subject{ LastFmApi::Base.new }

  describe '#new' do
    it "should have a base_url" do
      expect(subject.base_url).to eq("http://ws.audioscrobbler.com/2.0/")
    end
  end
end
