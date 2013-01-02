require 'foauth/rewrite_middleware'

describe Foauth::RewriteMiddleware do
  let(:conn) do
    conn = Faraday.new do |builder|
      builder.use Foauth::RewriteMiddleware
      builder.adapter :test do |stub|
        stub.get('/api.twitter.com/1/statuses/user_timeline.json') {[ 200, {}, '{}' ]}
      end
    end
  end

  it "changes the url for an intercepted request" do
    res = conn.get('https://api.twitter.com/1/statuses/user_timeline.json')
    expect(res.env[:url].to_s).to eq 'https://foauth.org/api.twitter.com/1/statuses/user_timeline.json'
  end
end