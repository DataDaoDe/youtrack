require "youtrack"

# Setup the client configuration
client = Youtrack::Client.new do |c|
  c.url = "http://example.your-youtrack.com"
  c.login = "demo"
  c.password = "demo"
end

# connect to the youtrack endpoint
# and save cookies in the client object
client.connect!



# create a project resource
# that inherits the connection
# from the client
project_resource = client.projects

# Get all accessible projects
project_list = project_resource.get_accessible_projects

# Get all issues for a particular project
project_id = "TT"
issue_list   = project_resource.get_issues_for(project_id)

# These methods require that the login/password user
# have admin privileges

# Get all projects
project_resource.all

# Find a project by ID (shortName in youTrack vernacular)
project_resource.find("TT")

# Delete a project
project_resource.destroy("TT")

# Create a project
# All are required except description
project_resource.create(
  projectId: "CC",
  projectName: "Cool Cats",
  startingNumber: 4,
  projectLeadLogin: "demo",
  description: "A Project about really awesome cats"
)
