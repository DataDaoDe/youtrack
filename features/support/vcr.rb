require "vcr"


VCR.config do |c|

  # tell vcr where to store recorded responses
  c.cassette_library_dir = "fixtures/cassette_library"
  
  # use webmock for stubbing
  c.hook_into :webmock

  # allow local requests
  c.ignore_localhost = true

  c.default_cassette_options = { record: :none }
end
