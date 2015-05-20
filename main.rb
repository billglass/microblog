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

navigation = {"Feed" => "/feed", "Account" => "/account", "Profile" => "/profile", "Members" => "/members"}


#still can follow yourself, fix that
#show unfollow links
#can't follow people you already follow - no duplicates

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
	@user = User.all
	@title = navigation.keys[1]
	@nav = navigation
	erb :account
end

post '/account' do
	@user = User.update(current_user, params[:user])
	@user.save
	puts "#{params.inspect}"
	redirect to ('/account')
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
	# @post = Post.new(params[:post]), user_id: current_user.id)
	@post.user = current_user
	@post.save
	puts "#{params.inspect}"
	redirect to ('/feed')
end

get '/profile/:username' do
	@user = User.find_by(username: params[:username])
	@title = navigation.keys[2]
	@nav = navigation
	erb :profile
end

post '/profile' do
	#something
end

get '/members' do
	@relationship = Relationship.find_by(follower_id: current_user.id, followed_id: params[:id])
	@title = "Members"
	@users = User.all
	@nav = navigation
	erb :members
end	

get '/users/:id' do
	@user = User.find(params[:id])
	erb :profile6
end

get '/follow/:id' do
	@relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:id])
	if @relationship.save
		flash[:notice] = "Successfully Followed"
	else
		flash[:alert] = "Error"
	end
	redirect to('/members')
end

get '/unfollow/:id' do
	@relationship = Relationship.find(params[:id])
	@relationship = nil
	redirect to('/members')
end

post '/logout' do
	session[:user_id] = nil
	redirect to ('/')
end

post '/delete' do
	current_user.destroy
	session.clear
	redirect to ('/')
end
