include WebMock::API

def server_url_for(endpoint, options={})
  base = "#{YServer::URL}/rest/#{endpoint}"
  if options[:query]
    base += "?#{options[:query]}"
  end
end


# STUBS

# login
stub_request(:post, server_url_for("login", query: "login=#{YServer::Password}&password=#{YServer::Login}"))
  .to_return(
    body: "<login>ok</login>",
    headers: {
      "Server" => "Jetty(6.1.23)",
      "Content-Type" => "application/xml;charset=UTF-8"
  })
