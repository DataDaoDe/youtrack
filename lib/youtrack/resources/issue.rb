module Youtrack
  class Issue < Base


    # ==================
    # USER Methods
    # ==================
    

    # Create a New Issue
    # project  string  ID of a project to add new issue to.
    # summary  string  Short summary for the new issue.
    # description  string  Description for the new issue.
    # attachments  file in "multipart/form-data" format  One or several files in "multipart/form-data" format that should be attached to the new issue.
    # permittedGroup   string  Set visibility for the new issue, that is: Specify a user group to which the issue will be visible.
    def create(attributes={})
      put("/issue", body: attributes)
      response
    end
    
  end
end