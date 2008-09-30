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
get '/' do
  title "index"
  @posts = Post.by_created_at
  haml :index
end

#get '/:id' do
#  @post = Post.
#end