require 'net/http/post/multipart'

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
      put("issue", body: attributes)
      response
    end

    def find(issue_id)
      get("issue/#{issue_id}")
      response.parsed_response
    end

    def get_history_for(issue_id)
      get("issue/#{issue_id}/history")
      response.parsed_response
    end

    def get_changes_for(issue_id)
      get("issue/#{issue_id}/changes")
      response.parsed_response
    end

    def exists?(issue_id)
      get("issue/#{issue_id}/exists")
      response.code == 200
    end

    def get_attachments_for(issue_id)
      get("issue/#{issue_id}/attachment")
      response.parsed_response
    end

    def get_comments_for(issue_id)
      get("issue/#{issue_id}/comment")
      response.parsed_response
    end

    def get_links_for(issue_id)
      get("issue/#{issue_id}/link")
      response.parsed_response
    end



    # issueID  string  ID of an issue that should be updated.
    # summary  string  New summary for the specified issue.
    # description  string  Updated description for the specified issue.
    def update(issue_id, attributes={})
      post("issue/#{issue_id}", body: attributes)
      response.parsed_response
    end

    def destroy(issue_id)
      delete("issue/#{issue_id}")
      response
    end

    def add_attachment(issue_id, data, content_type, filename)
      url = URI.parse(join(base_url, "issue/#{issue_id}/attachment"))
      req = Net::HTTP::Post::Multipart.new( url.path, "file" => UploadIO.new(data, content_type, filename))
      req['Cookie'] = service.cookies['Cookie']
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
      response
    end
    
  end
end