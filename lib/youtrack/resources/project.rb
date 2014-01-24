module Youtrack
  class Project < Base

    def initialize(client)
      super(client, 'project')
    end

    # ==================
    # USER Methods
    # ==================

    def all
      get('/')
      response.parsed_response
    end

    def find(project_id)
      get(project_id)
      response.parsed_response
    end

    def update(project_id, attributes)
      put(project_id, body: attributes)
      response
    end

    def destroy(project_id)
      delete(project_id)
      response
    end

    # ==================
    # ADMIN Methods
    # ==================
    
  end
end