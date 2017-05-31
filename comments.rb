require 'dm-core'
require 'dm-migrations'

class Comment
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :content, String
  property :created_at, String
end

DataMapper.finalize

get '/comment' do
  @comments = Comment.all
  erb :comments
end

get '/comment/new' do
  @comments = Comment.new
  erb :new_comment
end

get '/comments/:id' do
  redirect("/login") unless session[:admin]
  @comments = Comment.get(params[:id])
  erb :show_comment
end


post '/comment' do
  redirect("/login") unless session[:admin]
  comments = Comment.create(params['comments'])
  redirect to("/comments/#{comments.id}")
end

delete '/comments/:id' do
  redirect("/login") unless session[:admin]
  Comment.get(params[:id]).destroy
  redirect to('/comment')
end

