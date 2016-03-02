require 'bundler/setup'
require 'httparty'
require 'json'
require 'hashie'
require 'fileutils'
require 'time'
require 'dropbox_sdk'
require_relative './gmail.rb'
require_relative './gitHubApi.rb'
require_relative './alcatrazPackages.rb'


def save_json(json)
  file_path = "/public/alcatraz.json"
  client = DropboxClient.new(ENV['DROPBOX_TOKEN'])
  p client.put_file(file_path, json, true)
end

request = HTTParty.get 'https://raw.githubusercontent.com/alcatraz/alcatraz-packages/master/packages.json'; 1

begin
  request.inspect
  json = JSON.parse(request.parsed_response)
  packages = AlcatrazPackages.new.create(json)
  alcatraz_search_packages = GitHubRepositoryApi.new.start(packages)
  p save_json(alcatraz_search_packages.to_json)
rescue => e
  Gmail.new.send("AlcatrazSearch-package Error!!!", e.message)
  p e
end

