module Youtrack
  class User < Base


    # ==================
    # USER Methods
    # ==================
    def current
      get('user/current')
      response.parsed_response
    end

    def get_by_login(login_name)
      get("user/#{login_name}")
      response.parsed_response
    end

    def get_saved_searches_for(login_name)
      get("user/#{login_name}/filter")
      response.parsed_response
    end

    def get_saved_searches
      get("user/search")
      response.parsed_response
    end

    def get_saved_search_by_name(query_name)
      get("user/search/#{query_name}")
      response.parsed_response
    end

    # ==================
    # ADMIN Methods
    # ==================
    def find(login_name)
      get("admin/user/#{login_name}")
      response.parsed_response
    end

    def all
      get("admin/user")
      response.parsed_response
    end
    
    # login       string  Login name of a user to be created. Required.
    # fullName    string  User full name (optional).
    # email       string  User email (required for new user).
    # jabber      string  User jabber account (optional).
    # password    string  Password for the new user. If skipped, by default the new user account will be created with auto-generated password
    def create(attributes)
      put("admin/user", body: attributes)
      response
    end

    # User will be created if not already exist
    def update(attributes)
      post("admin/user", body: attributes)
      response
    end

    def destroy(login_name)
      delete("admin/user/#{login_name}")
      response
    end

    def get_roles_for(login_name)
      get("admin/user/#{login_name}/roles")
      response.parsed_response
    end

    def get_groups_for(login_name)
      get("admin/user/#{login_name}/groups")
      response.parsed_response
    end

  end
end