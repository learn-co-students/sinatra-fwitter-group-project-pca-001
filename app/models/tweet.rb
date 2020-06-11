require_relative "./concerns/slug.rb"

class Tweet < ActiveRecord::Base
  belongs_to :user

  include Slug
  extend Slug
end
