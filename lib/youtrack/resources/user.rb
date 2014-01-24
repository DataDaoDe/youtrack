module Youtrack
  class User < Base


    # USER Methods
    def current
      get('current')
      response.parsed_response
    end

    # ADMIN Methods

  end
end