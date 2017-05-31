require 'sinatra'
require 'erb'
require 'sass'
require './students'

configure do
  enable :sessions
  set :username, 'ruby'
  set :password, 'ruby'
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  DataMapper.auto_migrate!
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
  DataMapper.auto_migrate!
end

get('/styles.scss'){ scss :styles }

get '/' do
  # redirect("/login")
  erb :home
end

get "/login" do
  erb :login
end

post "/login" do
  if params["login"]["username"] == 'ruby' && params['login']['password'] == "ruby"
    # session[:admin] = true
    # redirect to ("/")
  else
    erb :login
  end
end

get "/logout" do
  session[:admin] = nil
  redirect to ("/")
end

get '/about' do
  # redirect("/login")
  @title = "All About This Website"
  erb :about
end

get '/contact' do
  # redirect("/login")
  erb :contact
end

get "/video" do
  erb :video
end

not_found do
  erb :not_found
end

