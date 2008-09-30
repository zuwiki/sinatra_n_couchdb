require 'couchrest'

class Post
  include CouchRest::Model
  use_database CouchRest.database!("http://localhost:5984/seclusion-test")

  view_by :created_at, :descending => true
  view_by :user_id, :date

  key_reader :created_at, :updated_at
  key_accessor :body, :tags
  
  timestamps!
end