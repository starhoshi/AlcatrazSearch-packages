require 'bundler/setup'
require 'hashie'
require 'json'
require 'httparty'

class GitHubRepositoryApi
  def create_repository_path

  end

  def fetch_repository(packages)
    packages.each do |package|
      # puts package["name"]
      puts package["url"]
      # puts package["description"]
      # puts package["screenshot"]
      # request = HTTParty.get 'aa'; 1
      #
      # begin
      #   request.inspect
      #   json = JSON.parse(request.parsed_response)
      #   packages = AlcatrazPackages.new.create(json)
      #   GitHubRepositoryApi.new.start(packages)
      # rescue => e
      #   p e.message
      #   # Gmail.new.send("AlcatrazSearch-package Error!!!", e.message)
      # end
    end
  end

  def start(alcatraz_packages)
    plugins = fetch_repository(alcatraz_packages[:plugins])
    color_schemes = fetch_repository(alcatraz_packages[:color_schemes])
    project_templates = fetch_repository(alcatraz_packages[:project_templates])
    file_templates = fetch_repository(alcatraz_packages[:file_templates])
  end
end
