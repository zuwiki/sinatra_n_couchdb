require 'couchrest'

class Post
  include CouchRest::Model
  use_database CouchRest.database!("http://localhost:5984/seclusion-test")

  view_by :created_at, :descending => true

  key_reader :created_at, :updated_at
  key_accessor :body, :children, :parent_id

  timestamps!

  def Post.first
    Post.by_created_at(:count => 1).first
  end

  def add_child(child_id)
    self.children = [] unless self.children
    self.children << child_id
    self.save
  end

  def get_children
    if self.children
      posts = []
      self.children.each do |id|
        posts << Post.get(id)
      end
    else
      return [] # Maybe this should return nil?
    end
  end

  def get_parent
    return Post.get(parent_id)
  end
end