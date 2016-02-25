require 'bundler/setup'
require 'hashie'
require 'json'

class BaseCoercableHash < Hash
  include Hashie::Extensions::Coercion
  include Hashie::Extensions::MergeInitializer
end

class Alcatraz < BaseCoercableHash
  coerce_key :description, String
  coerce_key :url, String
  coerce_key :name, String
  coerce_key :screenshot, String
end

class Packages < BaseCoercableHash
  coerce_key :plugins, Array[Alcatraz]
  coerce_key :color_schemes, Array[Alcatraz]
  coerce_key :project_templates, Array[Alcatraz]
  coerce_key :file_templates, Array[Alcatraz]
end

class AlcatrazPackages
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
