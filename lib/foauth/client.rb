module Foauth
  class Client
    def self.new(email, password)
      Faraday.new do |builder|
        builder.request :basic_auth, email, password
        builder.use RewriteMiddleware
        builder.adapter :net_http
      end
    end
  end
end