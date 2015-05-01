require 'sinatra'
require 'sinatra/activerecord'
# require 'rack-flash'
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
		else flash[:alert] = "Incorrect username/password"
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
	@title = navigation.keys[1]
	@nav = navigation
	erb :account
end

post '/account' do
	
end

get '/feed' do
	@title = navigation.keys[0]
	@nav = navigation
	@post =
	erb :feed
end

post '/feed' do
	#somthing
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