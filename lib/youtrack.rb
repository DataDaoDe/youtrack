require "httparty"

module Youtrack
  autoload :Client,   "youtrack/client"
  autoload :VERSION,  "youtrack/version"
  autoload :Base,     "youtrack/resources/base"
  autoload :Issue,    "youtrack/resources/issue"
  autoload :Project,  "youtrack/resources/project"
  autoload :User,     "youtrack/resources/user"
  autoload :Tag,      "youtrack/resources/tag"
end
