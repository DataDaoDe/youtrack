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

    # Get a list of issues for a search query.
    #
    # attributes
    #      filter  string   A query to search for issues.
    #      with    string   List of fields that should be included in the result.
    #      max     integer  Maximum number of issues to get. If not provided, only 10 issues will be returned by default.
    #      after   integer  A number of issues to skip before getting a list of issues.
    #
    def list attributes={}
      attributes[:max] ||= 10
      get("issue?#{URI.encode_www_form(attributes)}")
    end

    # Get the list of available work items for a particular issue.
    #
    # issue_id   string  youtrack ticket id
    #
    def get_work_items_for(issue_id)
      get("issue/#{issue_id}/timetracking/workitem/")
      response.parsed_response
    end

    # Add new work item to issue
    #
    # issue_id   string  youtrack ticket id
    # attributes    hash
    #      user         string  login name of the user who will be set as the author of the work item. (defaults to logged in user)
    #      date         string  date and time of the new work item in ISO8601 time format (defaults to current date)
    #      duration     string  Duration of the work item in minutes
    #      description  string  Activity description
    #
    def add_work_item_to(issue_id, attributes={})
      attributes = attributes.to_hash
      attributes.symbolize_keys!
      attributes[:date] ||= Date.current.iso8601
      epoc_date = Date.parse(attributes[:date]).to_time.to_i * 1000
      attributes[:user] ||= self.service.login
      work_items = REXML::Element.new('workItems')
      work_item = work_items.add_element('workItem')
      work_item.add_element('author').add_attribute('login', attributes[:user])
      work_item.add_element('date').add_text(epoc_date.to_s)
      work_item.add_element('duration').add_text(attributes[:duration].to_s)
      work_item.add_element('description').add_text(attributes[:description])
      put("import/issue/#{issue_id}/workitems", body: work_items.to_s, :headers => {'Content-type' => 'text/xml'} )
      response
    end

    # apply command
    #
    # issue_id   string  youtrack ticket id
    # attributes   hash
    #   command   string
    #   comment   string
    #   group   string
    #   disableNotifications   boolean
    #   runAs   string
    #
    def apply_command(issue_id, attributes={})
      post("issue/#{issue_id}/execute", query: attributes)
      response
    end
  end
end