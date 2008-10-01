require 'rubygems'
require 'sinatra'

### Configuration
configure do
  use_in_file_templates!
end

### Helpers
load "helpers.rb"

### Models
load "models.rb"

### Actions

# Lists all posts sorted by date
get '/' do
  title "index"
  @posts = Post.by_created_at
  haml :index
end

# Page for creating new posts
get '/post' do
  haml :new_post
end

# Endpoint for creating posts
post '/post' do
  post = Post.new
  post.body = params[:body]

  if params[:parent_id]
    parent = Post.get(params[:parent_id])
    post.parent_id = parent.id
  end

  # TODO: Validate first, or include validation by hacking up CouchRest
  post.save

  if parent
    parent.add_child(post.id)
  end

  redirect path_to_post(post)
end

# Individual views for posts
get '/post/:id' do
  @post = Post.get(params[:id])
  haml :post
end