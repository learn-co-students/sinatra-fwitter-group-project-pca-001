class Tweet < ActiveRecord::Base
  belongs_to :user

  def slug
    content.downcase.tr(" ", "-")
  end

  def self.find_by_slug(slug)
    all.find do |tweet|
      tweet.slug == slug
    end
  end

end
