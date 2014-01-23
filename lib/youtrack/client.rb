module Youtrack
  class Client
    include HTTParty

    # holds the youTrack Server url
    # defaults to nil
    attr_accessor :url

    # stores the Server login credential
    # defaults to nil
    attr_accessor :login
      
    # stores the Server password credential
    # defaulst to nil
    attr_accessor :password

    # stores the response object
    attr_accessor :response

    def initialize(options={})
    end

    def server_endpoint
      @server_endpoint ||= File.join(url, "rest")
    end

    def credentials_hash
      { login: login, password: password }
    end

    def login!
      @response = self.class.post(server_endpoint + "/login", { query: credentials_hash })
    end

  end
end
