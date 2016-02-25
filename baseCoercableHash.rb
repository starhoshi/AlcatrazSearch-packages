require 'bundler/setup'
require 'hashie'

class BaseCoercableHash < Hash
  include Hashie::Extensions::Coercion
  include Hashie::Extensions::MergeInitializer
end