require 'bundler/setup'
require 'hashie'
require 'json'
require 'httparty'
require 'octokit'
require 'uri'
require 'time'
require_relative './alcatrazPackages.rb'
require_relative './alcatrazSearchPackages.rb'
require_relative './gmail.rb'

class GitHubRepositoryApi
  def initialize
    @client = Octokit::Client.new access_token: ENV['GH_TOKEN']
  end

  def is_github(url)
    url.include?("github")
  end

  def is_github_gist(url)
    url.include?("gist")
  end

  def create_repository_path(url)
    uri = URI.parse(url)
    path = uri.path.split("/")
    owner = path[1]
    repo = path[2].gsub(".git", "")
    {:owner => owner, :repo => repo}
  end

  def load_repository_api(package)
    begin
      path = create_repository_path(package["url"])
      repository_json = @client.repository("#{path[:owner]}/#{path[:repo]}")
      AlcatrazSearchPackagesCreator.new.create(repository_json, package)
    rescue => e
      if e.class != Octokit::NotFound
        Gmail.new.send("AlcatrazSearch-package GitHub Api Error!!!", e.message)
      end
      AlcatrazSearchPackagesCreator.new.set_alcatraz_search(package)
    end
  end

  def fetch_repository(packages)
    repository_list = []
    packages.each do |package|
      url = package["url"]
      repository = nil
      if is_github_gist(url)
        # TODO: Get gist star, fork count. But gist api cannot get counts...
        repository = AlcatrazSearchPackagesCreator.new.set_alcatraz_search(package)
      elsif is_github(url)
        repository = load_repository_api(package)
      else
        repository = AlcatrazSearchPackagesCreator.new.set_alcatraz_search(package)
      end
      p repository
      repository_list.push(repository)
    end
    repository_list
  end

  def start(alcatraz_packages)
    plugins = fetch_repository(alcatraz_packages[:plugins])
    color_schemes = fetch_repository(alcatraz_packages[:color_schemes])
    project_templates = fetch_repository(alcatraz_packages[:project_templates])
    file_templates = fetch_repository(alcatraz_packages[:file_templates])
    project_templates.concat(file_templates)
    AlcatrazSearchPackages.new(
        created_at: Time.now.utc,
        plugins: plugins,
        color_schemes: color_schemes,
        templates: project_templates
    )
  end
end
