require "spec_helper"

describe Youtrack::User do
  let(:users) do
    client = Youtrack::Client.new do |c|
      c.url = "https://example.com"
      c.login = "test"
      c.password = "test"
    end
    client.users
  end

  describe "api methods" do
    it "#current" do
      users.method(:current).arity.should eq(0)
    end

    it "#get_by_login" do
      users.method(:get_by_login).arity.should eq(1)
    end

    it "#get_saved_searches_for" do
      users.method(:get_saved_searches_for).arity.should eq(1)
    end

  end

end
