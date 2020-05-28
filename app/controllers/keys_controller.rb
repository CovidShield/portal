require 'net/http'
require 'uri'
require 'json'

class KeysController < ApplicationController
  def generate
    uri = URI.parse("https://"+ ENV['KEY_CLAIM_HOST'] +"/new-key-claim")
    token = if Rails.env.production?
      Rails.application.credentials.key_claim_token
    else
      ENV['KEY_CLAIM_TOKEN']
    end
    header = {'Authorization': "Bearer #{token}" }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    request = Net::HTTP::Post.new(uri.request_uri, header)
    response = http.request(request)
    @key = response.body
    render text: @key
  end
end
