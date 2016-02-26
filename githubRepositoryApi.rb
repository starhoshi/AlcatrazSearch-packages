require 'bundler/setup'
require 'hashie'
require 'json'
require 'httparty'
require 'octokit'
require 'uri'
require './alcatrazPackages.rb'
require './alcatrazSearchPackages.rb'

class GitHubRepositoryApi
  def is_git_hub(url)
    url.include?("github")
  end

  def create_repository_path(url)
    uri = URI.parse(url)
    path = uri.path.split("/")
    owner = path[1]
    repo = path[2].gsub(".git", "")
    {:owner => owner, :repo => repo}
  end

  def fetch_repository(packages)
    packages.each do |package|
      alcatraz_search = AlcatrazSearch.new
      if is_git_hub(package["url"])
        path = create_repository_path(package["url"])
      else
        p "not github"
      end
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
