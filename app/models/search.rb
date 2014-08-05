class Search < ActiveRecord::Base
  attr_accessor :links, :tags

  def self.query_links(query)
    Link.where('display_name ~* ?', name)
  end

  def self.query_tags(query)
    Tag.where('display_name ~* ?', name)
  end

  def self.query(query)
    search = Search.new
    search.links = Search.query_links(query)
    search.tags = Search.query_tags(query)
    search
  end

  def json_ready
    hash = {
      links: search.links,
      tags: search.tags
    }
  end
end
