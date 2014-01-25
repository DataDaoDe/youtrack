
def fixture(filename)
  File.join(YServer::FIXTURE_PATH, filename)
end

Given /^I create a new Client$/ do
  @client = Youtrack::Client.new
end

Given /^I enter the correct login credentials$/ do
  step "I set the Client#login= to <#{YServer::Login}>"
  step "I set the Client#password= to <#{YServer::Password}>"
end

Given /^I enter incorrect login credentials$/ do
  step "I set the Client#login= to <#{YServer::Lorem}>"
  step "I set the Client#password= to <#{YServer::Lorem}>"
end

Given /^I set the Client url to point to the Server$/ do
  @client.url = YServer::URL
end

Given /^I connect ok$/ do
  @client.connect!
end

Given /^I connect with error$/ do
  @client.connect!
end

Given /^I set the Client#([a-zA-Z_=]+) to <([a-zA-Z0-9_-]+)>$/ do |method, value|
   @client.__send__(method, value)
end

Then /^I should be connected to the Server$/ do
  @client.response.parsed_response["login"].should eq("ok")
end

Then /^I should receive an error response from the Server$/ do
end

Then(/^I should receive an error Response$/) do
  @client.response.parsed_response['error'].should eq('Incorrect login or password.')
end
