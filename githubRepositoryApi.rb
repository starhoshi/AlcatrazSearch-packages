require 'bundler/setup'
require 'hashie'
require 'json'
require 'httparty'
require 'octokit'
require 'uri'
require './alcatrazPackages.rb'
require './alcatrazSearchPackages.rb'

class GitHubRepositoryApi
  def setup_octokit
    config = YAML.load_file("settings.yml")
    Octokit::Client.new access_token: config["github_token"]
  end

  def is_github(url)
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
    client = setup_octokit
    packages.each do |package|
      alcatraz_search = AlcatrazSearch.new
      if is_github(package["url"])
        path = create_repository_path(package["url"])
        # p package["url"]
        p client.repository("#{path[:owner]}/#{path[:repo]}")
      else
        p " not github "
      end
    end
  end

  def start(alcatraz_packages)
    plugins = fetch_repository(alcatraz_packages[:plugins])
    color_schemes = fetch_repository(alcatraz_packages[:color_schemes])
    project_templates = fetch_repository(alcatraz_packages[:project_templates])
    file_templates = fetch_repository(alcatraz_packages[:file_templates])
  end
end
