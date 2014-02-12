module Youtrack
  class Project < Base

    # ==================
    # USER Methods
    # ==================
    def get_accessible_projects
      get('project/all')
      response.parsed_response
    end

    # filter        string    Apply a filter to issues in a project.
    # after         Integer   A number of issues to skip before getting a list of issues. That is, when you specify, for example, after=12 in request, 
    #                         then in the response you will get all issues matching request but without first twelve issues found .
    # max           Integer   Maximum number of issues to be imported. If not provided, 10 issues will be imported, by default.
    # updatedAfter  Long      Filter issues by the date of the most recent update. Only issues imported after the specified date will be gotten.
    def get_issues_for(project_id, options={})
      get("issue/byproject/#{project_id}")
      response.parsed_response
    end

    # ==================
    # ADMIN Methods
    # ==================
    def all
      get('admin/project')
      response.parsed_response
    end

    def find(project_id)
      get("admin/project/#{project_id}")
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
      put("admin/project/#{attributes[:projectId]}", query: attributes)
      response
    end

    def destroy(project_id)
      delete("admin/project/#{project_id}")
      response
    end
    
  end
end
