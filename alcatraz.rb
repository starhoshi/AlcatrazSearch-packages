require 'bundler/setup'
require 'httparty'
require 'json'
require 'hashie'
require 'fileutils'
require 'time'
require './gmail.rb'
require './gitHubRepositoryApi.rb'
require './alcatrazPackages.rb'


def save_json(json)
  file_path = "./data/alcatraz.json"
  if File.exist?(file_path)
    FileUtils.mv(file_path, "#{file_path}.#{Time.now.to_i}")
  end
  open(file_path, 'w') do |io|
    JSON.dump(json, io)
  end
end

request = HTTParty.get 'https://raw.githubusercontent.com/alcatraz/alcatraz-packages/master/packages.json'; 1

begin
  request.inspect
  json = JSON.parse(request.parsed_response)
  packages = AlcatrazPackages.new.create(json)
  alcatraz_search_packages = GitHubRepositoryApi.new.start(packages)
  p save_json(alcatraz_search_packages)
rescue => e
  # Gmail.new.send("AlcatrazSearch-package Error!!!", e.message)
  p e
end

