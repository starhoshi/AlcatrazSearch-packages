require 'bundler/setup'
require 'hashie'
require 'json'
require './baseCoercableHash.rb'

class AlcatrazSearch < BaseCoercableHash
  coerce_key :description, String
  coerce_key :url, String
  coerce_key :name, String
  coerce_key :screenshot, String
end

class GithubRepository < BaseCoercableHash
  coerce_key :plugins, Array[AlcatrazSearch]
  coerce_key :color_schemes, Array[AlcatrazSearch]
  coerce_key :project_templates, Array[AlcatrazSearch]
  coerce_key :file_templates, Array[AlcatrazSearch]
end

class AlcatrazSearchPackages
  def create(json)
    packages = json["packages"]
    Packages.new(
        plugins: packages["plugins"],
        color_schemes: packages["color_schemes"],
        project_templates: packages["project_templates"],
        file_templates: packages["file_templates"]
    )
  end
end
