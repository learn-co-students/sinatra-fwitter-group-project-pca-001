require_relative "./concerns/slug.rb"

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  include Slug
  extend Slug
end
