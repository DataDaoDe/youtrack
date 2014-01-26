require "youtrack"

# Setup the client configuration
client = Youtrack::Client.new do |c|
  c.url = "http://example.your-youtrack.com"
  c.login = "demo"
  c.password = "demo"
end

# connect to the youtrack endpoint
# and save cookies in the client object
client.connect!
