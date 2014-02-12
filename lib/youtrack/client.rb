module Youtrack
  class Client

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
    attr_accessor :connection

    # stores the auth_headers
    attr_accessor :cookies

    # stores the scope of all subsequent api calls
    attr_accessor :admin

    def admin?
      true == @admin
    end

    def initialize(options={}, &block)
      @cookies = {}
      @admin   = false

      yield(self) if block_given?
    end

    # the server endpoint
    def endpoint
      @endpoint = File.join(url, 'rest')
    end

    def credentials_hash
      { login: login, password: password }
    end


    # Makes a login call and sets the Cookie headers
    # 
    # Returns the status code of the connection call
    def connect!
      @connection = HTTParty.post(File.join(url, "rest/user/login"), body: credentials_hash )
      @cookies['Cookie'] = @connection.headers['set-cookie']
      @connection.code
    end

    def connected?
      !!(connection && connection.headers['set-cookie'] && connection.code == 200)
    end

    def users
      resource(:user).new(self)
    end

    def projects
      resource(:project).new(self)
    end

    def issues
      resource(:issue).new(self)
    end

    def tags
      resource(:tag).new(self)
    end

    private

      def resource(resource_name)
        Youtrack.const_get(resource_name.to_s.capitalize)
      end
  end
end
