require "spec_helper"

describe Youtrack::User do
  describe "api methods" do
    use_vcr_cassette "users/init", record: :new_episodes

    let(:users) do 
      client = build_client("https", "testuser", "testuser")
      client.connect!
      client.users
    end

    context "#current" do
      use_vcr_cassette "users/current", record: :new_episodes
      
      it "should take no arguments" do
         expect(users.method(:current).arity).to eq(0)
      end

      it "should return info about the currently authenticated user" do
        entity_body = users.current
        
        # STATUS
        expect(users.response.code).to                      eq(200)

        # BODY
        expect(entity_body["user"]).to  be_kind_of(Hash)
        user_hash = entity_body["user"]

        expect(user_hash.keys).to include("login")
        expect(user_hash.keys).to include("email")
        expect(user_hash.keys).to include("fullName")
      end

    end

    context "#get_by_login" do
      use_vcr_cassette "users/get_by_login", record: :new_episodes

      it "should take one argument the user's login name" do
        users.method(:get_by_login).arity.should eq(1)
      end

      it "should return info about a searched for user" do
        entity_body = users.get_by_login("testuser")

        # STATUS
        expect(users.response.code).to        eq(200)

        # BODY
        user_hash = entity_body["user"]
        expect(user_hash).to                  be_kind_of(Hash)
        expect(user_hash["login"]).to_not     eq(nil)
        expect(user_hash["email"]).to_not     eq(nil)
        expect(user_hash["fullName"]).to_not  eq(nil)

      end
    end

    context "#get_saved_searches_for" do
      use_vcr_cassette "users/get_saved_searches_for", record: :new_episodes

      it "should take one argument the user's login name" do
        users.method(:get_saved_searches_for).arity.should eq(1)
      end

      it "should return a list of the user's saved searches with name/query keys" do
        entity_body = users.get_saved_searches_for("testuser")

        # STATUS
        expect(users.response.code).to                  eq(200)

        # BODY
        query_ary = entity_body["queries"]["query"].first
        expect(query_ary).to                            be_kind_of(Hash)
        expect(query_ary["name"]).to_not                eq(nil)
        expect(query_ary["query"]).to_not               eq(nil)
      end
    end

  end

end
