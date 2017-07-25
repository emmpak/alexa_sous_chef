require 'sinatra/base'
require 'json'
require 'alexa_verifier'
require './lib/alexa/skill'
require './lib/alexa/request'
require './lib/alexa/response'
require './lib/recipe'

class AlexaChef < Sinatra::Base
  FatSecret.init(ENV["FATSECRET_KEY"],ENV["FATSECRET_SECRET"])

  # configure do
  #   $stdout.sync = true
  #   verifier = AlexaVerifier.build do |c|
  #     c.verify_signatures = true
  #     c.verify_timestamps = true
  #     c.timestamp_tolerance = 60 # seconds
  #   end
  #   set :cert_verifier, verifier
  # end
  #
  # before do
  #   content_type :json
  # end
  #
  post '/' do
  #   puts "Received request with headers:\n#{request.env}"
  #   verification_success = settings.cert_verifier.verify!(
  #     request.env["HTTP_SIGNATURECERTCHAINURL"],
  #     request.env['HTTP_SIGNATURE'],
  #     request.body.read
  #   )
  #   raise "Cert validation failed" unless verification_success

    Alexa::Handlers.handle(request)
  end
end
