require 'net/http/post/multipart'
require 'uri'

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
    #
    # Hack: the body has to be set to empty so that HTTParty sends a Content-Length header, which Youtrack requires
    #
    # API-Success: Returns a 201 created wit hthe location header set
    #
    # Returns the response object
    def create(attributes={})
      put("issue", query: attributes, body: {})
      response
    end

    def find(issue_id)
      get("issue/#{issue_id}")
      response.parsed_response
    end

    def count(filter)
      get("issue/count?filter=#{URI.encode(filter)}")
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
      post("issue/#{issue_id}", query: attributes)
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
      http = Net::HTTP.new(url.host, url.port)
      http.set_debug_output($stderr) if service.debug
      
      if url.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end

      response = http.request(req)
      response
    end


    def add_comment(issue_id, attributes={})
      post("issue/#{issue_id}/execute", query: attributes)
      response
    end
    
  end
end