module Youtrack
  class Tag < Base
    
    # get all user's tags
    def get_all_tags
      get('user/tag')
      response.parsed_response
    end

    # get a user's tag by name
    def get_tag_by_name( tag_name )
      get("user/tag/#{tag_name}")
      response.parsed_response
    end

    # add new user's tag
    # 
    # attributes:
    # tagName (required)         String The name of the new tag
    # visibleForGroup (required) String Name of a user group in which tag should be visible
    # updatableByGroup (required) String Name of user group whose members can edit the new tag
    # untagOnResolve (optional)  Boolean autoremove when issue's state changes
    #
    # API Success: Returns 201 Created with Location Header set
    # Returns the response object

    def create(attributes={})
      tag_name = attributes.delete(:tagName)
      put("user/tag/#{tag_name}", attributes)
      response
    end

    # update an existing tag
    # 
    # attributes:
    # tagName (required)         String The name of tag to edit.
    # newName (required)         String the new name for the tag.
    # visibleForGroup (required) String Name of a user group in which tag should be visible
    # updatableByGroup (required) String Name of user group whose members can edit the new tag
    # untagOnResolve (optional)  Boolean autoremove when issue's state changes
    #
    # API Success: Returns 301 Moved Permanently with Location Header set
    # Returns the response object

    def update(attributes={})
      tag_name = attributes.delete(:tagName)
      post("user/tag/#{tag_name}", attributes)
      response
    end

  end
end
