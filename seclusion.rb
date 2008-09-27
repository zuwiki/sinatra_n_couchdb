require 'rubygems'
require 'sinatra'
require 'relaxdb'

### Configuration
configure do
  RelaxDB.configure :host => "localhost", :port => 5984
  RelaxDB.use_db "crikey"

  use_in_file_templates!
end

### Helpers
load "helpers.rb"

### Models
class Post < RelaxDB::Document
  property :created_at
  property :contents

  # This alias is to give us pretty %tag[obj] syntax in Haml
  alias :id :_id
end

### Actions
get '/' do
  title "index"
  @posts = Post.all.sorted_by(:created_at)
  haml :index
end

#get '/:id' do
#  @post = Post.
#end