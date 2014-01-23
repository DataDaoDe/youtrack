
Given /^I create a new Client$/ do
  @client = Youtrack::Client.new
end

Given /^I enter the correct login credentials$/ do
  step "I set the Client#login= to <#{YServer::Login}>"
  step "I set the Client#password= to <#{YServer::Password}>"
end

Given /^I set the Client url to point to the Server$/ do
  @client.url = YServer::URL
end

Given /^I connect$/ do
  @client.login!
end

Given /^I set the Client#([a-zA-Z_=]+) to <([a-zA-Z0-9_-]+)>$/ do |method, value|
   @client.__send__(method, value)
end

Then /^I should be connected to the Server$/ do
  @client.response.parsed_response["login"].should eq("ok")
end
