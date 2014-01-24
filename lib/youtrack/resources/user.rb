module Youtrack
  class User < Base
    
    def initialize(client)
      super(client, 'user')
    end


    # USER Methods
    def current
      get('current')
      response.parsed_response
    end

    # ADMIN Methods

  end
end