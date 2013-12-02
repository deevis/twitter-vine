twitter-vine
============

[![Build Status](https://travis-ci.org/deevis/twitter-vine.png?branch=master)](https://travis-ci.org/deevis/twitter-vine)
[![Dependency Status](https://gemnasium.com/deevis/twitter-vine.png)](https://gemnasium.com/deevis/twitter-vine)
[![Gem Version](https://badge.fury.io/rb/twitter-vine.png)](http://badge.fury.io/rb/twitter-vine)

A ruby based API to get information about Vines and allow searching.

## Installation
    gem install twitter-vine
    

## Usage

```ruby
TwitterVine::Client.setup do |config|
  config.api_key        = "YOUR_API_KEY"
  config.api_secret     = "YOUR_API_SECRET"
  config.oauth_token    = "YOUR_OAUTH_TOKEN"
  config.oauth_secret   = "YOUR_OAUTH_SECRET"
end
```

```ruby
vines = TwitterVine::Client.search("Prank")
```
