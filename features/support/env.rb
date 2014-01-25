require "youtrack"
require "webmock"
include WebMock::API

module YServer
  URL = "https://youtrackserver.com"
  Endpoint = "#{URL}/rest"
  Login = "root"
  Lorem = 'lorem'
  Password = "root"
  FIXTURE_PATH = File.expand_path('../../../spec/fixtures', __FILE__ )
  COOKIE = "jetbrains.charisma.main.security.PRINCIPAL=NmZkNDc3NDgxZjBhOWNjMTVjNDQwNTljNTE1NzM1ODEwM2I3MjgyMDlkZDAzZGJhYTAzYzU1ZmYyZGUyZWMxNzpyb290;Path=/youtrack;Expires=Sat, 24-Jan-2015 07:49:19 GMT"
end

def fixture(filename)
  File.read(YServer::FIXTURE_PATH + "/#{filename}")
end

#=========================
# Request Stubs
#=========================

stub_request(:post, "#{YServer::Endpoint}/user/login").
        with(:body => "login=#{YServer::Login}&password=#{YServer::Password}").
        to_return(:status => 200, body: fixture('login_body_ok.xml'), :headers => { 'set-cookie' => YServer::COOKIE })

stub_request(:post, "#{YServer::Endpoint}/user/login").
        with(:body => "login=#{YServer::Lorem}&password=#{YServer::Lorem}").
        to_return(:status => 403, body: fixture('login_body_error.xml'), :headers => { 'set-cookie' => YServer::COOKIE })