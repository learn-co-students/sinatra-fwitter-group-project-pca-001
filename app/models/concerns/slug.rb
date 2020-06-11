module Slug
  def slug
    username.parameterize
  end

  def find_by_slug(slug)
    all.find { |instance| instance.slug == slug }
  end
end
