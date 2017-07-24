require 'sinatra/base'
require 'json'
require 'alexa_verifier'
require './lib/alexa/skill'
require './lib/alexa/request'
require './lib/alexa/response'
require './lib/recipe'

class AlexaChef < Sinatra::Base
  FatSecret.init(ENV["FATSECRET_KEY"],ENV["FATSECRET_SECRET"])

  post '/' do
    verification_success = AlexaVerifier.new.verify!(
    request.headers["HTTP_SIGNATURECERTCHAINURL"],
    request.headers['HTTP_SIGNATURE'],
    request.body.read
    )
    raise "Cert validation failed" unless verification_success

    Alexa::Handlers.handle(request)
  end
end
