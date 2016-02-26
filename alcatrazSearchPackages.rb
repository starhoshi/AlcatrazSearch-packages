require 'bundler/setup'
require 'hashie'
require 'json'
require './baseCoercableHash.rb'

class AlcatrazSearch < BaseCoercableHash
  coerce_key :description, String
  coerce_key :url, String
  coerce_key :name, String
  coerce_key :screenshot, String
  coerce_key :open_issues_count, Integer
  coerce_key :stargazers_count, Integer
  coerce_key :forks_count, Integer
  coerce_key :watchers_count, Integer
  coerce_key :updated_at, String
  coerce_key :created_at, String
  coerce_key :pushed_at, String
end

class AlcatrazSearchPackages < BaseCoercableHash
  coerce_key :created_at, String
  coerce_key :plugins, Array[AlcatrazSearch]
  coerce_key :color_schemes, Array[AlcatrazSearch]
  coerce_key :project_templates, Array[AlcatrazSearch]
  coerce_key :file_templates, Array[AlcatrazSearch]
end

class AlcatrazSearchPackagesCreator
  def initialize_package
    alcatraz_search = AlcatrazSearch.new
    alcatraz_search[:open_issues_count] = nil
    alcatraz_search[:stargazers_count] = nil
    alcatraz_search[:forks_count] = nil
    alcatraz_search[:watchers_count] = nil
    alcatraz_search[:updated_at] = nil
    alcatraz_search[:created_at] = nil
    alcatraz_search[:pushed_at] = nil
    alcatraz_search
  end

  def set_alcatraz_search(package, alcatraz_search = initialize_package)
    alcatraz_search[:name] = package["name"]
    alcatraz_search[:url] = package["url"]
    alcatraz_search[:description] = package["description"]
    alcatraz_search[:screenshot] = package["screenshot"]
    alcatraz_search
  end

  def create(repository_json, package)
    alcatraz_search = AlcatrazSearch.new
    alcatraz_search[:open_issues_count] = repository_json["open_issues_count"]
    alcatraz_search[:stargazers_count] = repository_json["stargazers_count"]
    alcatraz_search[:forks_count] = repository_json["forks_count"]
    alcatraz_search[:watchers_count] = repository_json["watchers_count"]
    alcatraz_search[:updated_at] = repository_json["updated_at"]
    alcatraz_search[:created_at] = repository_json["created_at"]
    alcatraz_search[:pushed_at] = repository_json["pushed_at"]
    set_alcatraz_search(package, alcatraz_search)
  end
end
