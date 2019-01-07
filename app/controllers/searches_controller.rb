class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = ENV["FOURSQUARE_CLIENT_ID"]
      req.params['client_secret'] = ENV["FOURSQUARE_SECRET"]
      req.params['q'] = 'query'
      req.params['near'] = params[:zipcode]
      req.params['query'] = "coffee shop"
    end

     body_hash = JSON.parse(@resp.body)

     if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end

     rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

     render :search
    end
end
