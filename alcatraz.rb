require 'bundler/setup'
require 'httparty'
require 'json'
require 'hashie'
require './gmail.rb'
require './alcatrazPackages.rb'

request = HTTParty.get 'https://raw.githubusercontent.com/alcatraz/alcatraz-packages/master/packages.json'; 1

begin
  request.inspect
  json = JSON.parse(request.parsed_response)
  packages = AlcatrazPackages.new.create(json)
  puts packages[:plugins]

rescue => e
  p e.message
  # Gmail.new.send("AlcatrazSearch-package Error!!!", e.message)
end

