require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
require './models'

set :database, "sqlite3:comic.sqlite3"
set :sessions, true
use Rack::Flash, sweep: true

def current_user
	session[:user_id] ? User.find(session[:user_id]) : nil
end	

navigation = {"Feed" => "/feed", "Account" => "/account", "Profile" => "/profile"}

#mapping a PATTERN, not an exact URL
#: = key
# get '/follow/:id' do
# 	@relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:id])
# 	if @relationship.save
# 		flash[:notice] = "Successfully followed"
# 	else
# 		flash[:alert] = "something went wrong"
# 	end
# 		redirect('/')
# 	puts params.inspect
# end

# #gets every user
# get '/users' do
# 	@users = User.all
# 	erb :index
# end

# #gets specific profile page
# get '/users/:id' do
# 	@user = User.find(params[:id])
# 	erb :show
# end

get '/' do
	@title = "Zap!"
	@nav = navigation
	erb :home
end

post '/login' do
	@user = User.find_by(username: params[:username])
		if @user and @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:notice] = "Welcome Back #{current_user.username}"
			redirect to ('/feed')
			puts "#{params.inspect}"
		else 
			flash[:alert] = "Incorrect username/password"
			redirect to ('/')
		end
end


post '/sign_up' do
		# Usernames are unique - loop through usernames, if @new_user is taken already, flash :alert?
	@new_user = User.create(params[:user])
	session[:user_id] = @new_user.id
	puts "#{params.inspect}"
	redirect to ('/account')
end

get '/account' do
	# @users = User.all
	@title = navigation.keys[1]
	@nav = navigation
	erb :account
end

post '/account' do
	@users = User.all
	puts "#{params.inspect}"
	redirect to ('/account')
 redirect to('/account')
end

#method called "posts"

get '/feed' do
	@title = navigation.keys[0]
	@nav = navigation
	# @post = Post.find_by(post: params[:post])
	erb :feed
end

post '/feed' do
	@post = Post.new(post: params[:post][:post])
	# @post = Post.new(params[:post])   #, user_id: current_user.id)
	# @post.user = current_user
	@post.save
	puts "#{params.inspect}"
	redirect to ('/feed')
end

get '/profile' do
	@title = navigation.keys[2]
	@nav = navigation
	erb :profile
end

post '/profile' do
	#something
end

post '/logout' do
	session[:user_id] = nil
	redirect to ('/')
end