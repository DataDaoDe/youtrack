# Youtrack

youTrack REST API Client

[![Build Status](https://travis-ci.org/jwaterfaucett/youtrack.png)](https://travis-ci.org/jwaterfaucett/youtrack)
[![Gem Version](https://badge.fury.io/rb/youtrack.png)](http://badge.fury.io/rb/youtrack)

## Installation

Add this line to your application's Gemfile:

    gem 'youtrack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youtrack

## Usage

```ruby

client = Youtrack::Client.new do |c|
  c.url = "https://example.com"
  c.login = "root"
  c.password = "root"
end

```

## Issues

Any issues or bugs should be well documented submit as many details as possible.
The best issues have the following characteristics:

1. Detail description with a title that conveys the problem well.
2. Gists and/or failing tests that show under what conditions the problem occurs.
3. Environment information, platform, gem version, etc.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write your feature in Cucumber.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Make sure your feature and (optional) Rspec test are green.
6. Rebase from master.
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request.
