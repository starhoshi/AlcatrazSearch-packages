require 'bundler/setup'
require 'httparty'
require 'json'
require 'hashie'

response = HTTParty.get('https://raw.githubusercontent.com/alcatraz/alcatraz-packages/master/packages.json')
json = JSON.parse(response)
mash = Hashie::Mash.new(json)
p mash.packages

# case response.code
#   when 200
#     p response
#     puts "All good!"
#   when 404
#     puts "O noes not found!"
#   when 500...600
#     puts "ZOMG ERROR #{response.code}"
# end
#
#

