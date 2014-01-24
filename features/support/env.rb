require "youtrack"

module YServer
  URL = "https://youtrackserver.com"
  Endpoint = "#{URL}/rest"
  Login = "root"
  Lorem = 'lorem'
  Password = "root"
  FIXTURE_PATH = File.expand_path('../../../spec/fixtures', __FILE__ )
end

require 'webmock/cucumber'
World(WebMock::API, WebMock::Matchers)
WebMock.allow_net_connect!