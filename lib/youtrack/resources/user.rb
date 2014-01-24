module Youtrack
  class User < Base
    
    def initialize(service)
      endpoint= service
      base_url= 'user'
    end

  end
end