module Alexa
  class Request

    attr_reader :request

    def initialize(sinatra_request)
      @request = JSON.parse(sinatra_request.body.read)
    end

    def slot_value(slot_name)
      self.request['request']['intent']['slots'][slot_name]['value']
    end

    def session_attribute(attribute_name)
      @request["session"]["attributes"][attribute_name]
    end
  end
end
