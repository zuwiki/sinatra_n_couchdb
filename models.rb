require 'couchrest'

class Post
  include CouchRest::Model
  use_database CouchRest.database!("http://localhost:5984/seclusion-test")

  view_by :created_at, :descending => true

  key_reader :created_at, :updated_at
  key_accessor :body, :children, :parent_id

  timestamps!

  ## Some query helpers
  def Post.first
    Post.by_created_at(:count => 1).first
  end

  def add_child(child_id)
    children = [] unless children
    children << child_id
    save
  end

  def get_children
    if children
      posts = []
      children.each do |id|
        posts << Post.get(id)
      end
    else
      return nil # Maybe this should return [] ?
    end
    return posts
  end

  def get_parent
    if parent_id
      return Post.get(parent_id)
    else
      return nil
    end
  end
end