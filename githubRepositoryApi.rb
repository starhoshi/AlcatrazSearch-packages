require 'bundler/setup'
require 'hashie'
require 'json'
require 'httparty'

class GitHubRepositoryApi
  def create_repository_path

  end

  def fetch_repository(packages)
    packages.each do |package|
      puts package["name"]
      puts package["url"]
      puts package["description"]
      puts package["screenshot"]
    end
  end

  def start(alcatraz_packages)
    plugins = fetch_repository(alcatraz_packages[:plugins])
    color_schemes = alcatraz_packages[:color_schemes]
    project_templates = alcatraz_packages[:project_templates]
    file_templates = alcatraz_packages[:file_templates]
  end
end
