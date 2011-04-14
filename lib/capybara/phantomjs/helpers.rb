require 'yajl'
require 'multi_json'
require 'rest-client'

module Capybara
  module Phantomjs
    class NodeError < ::StandardError
    end

    module Helpers
      def encode(value)
        MultiJson.encode(value)
      end

      def decode(value)
        MultiJson.decode(value)
      end

      def http_send(js)
        decode(RestClient.post("http://127.0.0.1:8124", :payload => js))
      end
    end
  end
end
