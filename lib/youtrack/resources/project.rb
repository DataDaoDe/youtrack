module Youtrack
  class Project < Base

    # ==================
    # USER Methods
    # ==================
    def accessible_projects
      get('/project/all')
      response.parsed_response
    end

    # ==================
    # ADMIN Methods
    # ==================
    def all
      get('/admin/project')
      response.parsed_response
    end

    def find(project_id)
      get("/admin/project/#{project_id}")
      response.parsed_response
    end

    # required attributes
    # 
    # projectId  string required Unique identifier of a project to be created. This short name will be used as prefix in issue IDs for this project.
    # projectName  string required Full name of a new project. Must be unique.
    # startingNumber   integer  required Number to assign to the next manually created issue.
    # projectLeadLogin   string required Login name of a user to be assigned as a project leader.
    # description  string  Optional description of the new project
    def create(attributes={})
      put("admin/project/#{attributes[:projectId]}", body: attributes)
      response
    end

    def destroy(project_id)
      delete("/admin/project/#{project_id}")
      response
    end
    
  end
end