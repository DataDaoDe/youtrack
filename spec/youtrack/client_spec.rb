require "spec_helper"

describe Youtrack::Client do

  describe "attributes" do 

    # Mutators
    it { should respond_to(:url=) }
    it { should respond_to(:login=) }
    it { should respond_to(:password=) }
    it { should respond_to(:cookies=) }
    it { should respond_to(:connection=) }
    it { should respond_to(:admin=) }

    # Accessors
    it { should respond_to(:admin?) }
    it { should respond_to(:connected?) }
    it { should respond_to(:credentials_hash) }
    it { should respond_to(:endpoint) }
  end

  describe "resources" do
    it { should respond_to(:users) }
    it { should respond_to(:projects) }
    it { should respond_to(:issues) }
  end

  describe "connecting" do
    
    context "success" do
      let(:client) { build_client("https", "testuser", "testuser") }
      use_vcr_cassette "client/connect"

      it "should connect to a youtrack endpoint when having valid credentials" do
        client.connect!
        
        # STATUS
        expect(client.connected?).to          eq(true)
        expect(client.connection.code).to     eq(200)
        expect(client.connection.message).to  eq("OK")
        
        # MESSAGE
        entity_body = client.connection.parsed_response
        expect(entity_body["error"]).to eq(nil)
        expect(entity_body["login"]).to eq("ok")

        # AUTH COOKIE
        expect(client.connection.response["set-cookie"]).to match(%r{jetbrains.charisma.main.security})
      end
    
    end

    context "credentials failure" do
      let(:client) { build_client("https", "invalid_user", "invalid_pass") }
      use_vcr_cassette "client/connect_credentials_error"

      it "should not connect to a youtrack endpoint when credentials are invalid" do
        client.connect!

        # STATUS
        expect(client.connected?).to          eq(false)
        expect(client.connection.code).to     eq(403)
        expect(client.connection.message).to  eq("Forbidden")

        # MESSAGE
        entity_body = client.connection.parsed_response
        expect(entity_body["login"]).to eq(nil)
        expect(entity_body["error"]).to eq("Incorrect login or password.")
        
        # AUTH COOKIE
        expect(client.connection.response["set-cookie"]).to_not match(%r{jetbrains.charisma.main.security})
      end
    end

    context "url endpoint failure" do
      let(:client) { build_client("https", "testuser", "testuser") }
      use_vcr_cassette "client/connect_url_error"

      it "should not connect to a youtrack endpoint when the url is invalid" do
        client.url = "https://testcloud.myjetbrains.com/youtracks"
        client.connect!

        # STATUS
        expect(client.connected?).to          eq(false)
        expect(client.connection.code).to     eq(404)
        expect(client.connection.message).to  eq("Not Found")
         
      end
    end

  end
end
