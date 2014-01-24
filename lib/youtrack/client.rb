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

    # stores the auth_headers
    attr_accessor :cookies

    def initialize(options={})
      @cookies = {}
    end

    # the server endpoint
    def endpoint
      @endpoint ||= File.join(url, "rest")
    end

    def credentials_hash
      { login: login, password: password }
    end


    # Makes a login call and sets the Cookie headers
    def connect!
      @response = self.class.post(endpoint + "/login", body: credentials_hash, headers: { 'Accepts' => 'application/xml' })
      puts @response.inspect
      @cookies['Set-Cookie'] = @response['Set-Cookie']
    end

  end
end
