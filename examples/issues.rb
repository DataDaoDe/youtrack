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


# Get the issue resource inheriting cookies
# from client
issue_resource = client.issues

# Find an issue by ID
issue_resource.find("TT-6")

# Check if an issue exists
issue_resource.exists?("TT-6")

# Getting issue associated data
issue_resource.get_history_for("TT-6")
issue_resource.get_changes_for("TT-6")
issue_resource.get_attachments_for("TT-6")
issue_resource.get_comments_for("TT-6")
issue_resource.get_links_for("TT-6")

# Create an Issue
issue_resource.create(
  project: "TT",
  summary: "An example Bug",
  description: "This Bug is evil",
  type: 'bug',
  priority: 'critical',
  state: 'open'
)

# Update an Issue
issue_id = "TT-6"
issue_resource.update( issue_id , summary: "Evil Bug")

# Delete
issue_resource.destroy(issue_id)

# Add attachments to an issue
data = File.open("/tmp/dummy.txt")
content_type = "text/plain"
filename = "dummy.txt"
issue_resource.add_attachment(issue_id, data, content_type, filename )

# Add comments to an issue
issue_resource.add_comment(issue_id, comment: "This bug has been fixed")
