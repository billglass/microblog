require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require 'pry'
require 'bundler/setup'
require './models'

set :database, "sqlite3:comic.sqlite3"
set :sessions, true
use Rack::Flash, sweep: true

get '/' do
	erb :home
end

post '/login' do
	@user = User.find_by(params[:user])
		if @user and @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:notice] = "Welcome Back #{@user}"
			redirect to ('/feed')
		else flash[:alert] = "Incorrect username/password"
			redirect to ('/')
		end
end

post '/sign_up' do
	# Usernames are unique - loop through usernames, if @new_user is taken already, flash :alert?
	@new_user = User.create(params[:user])
	session[:user_id] = @new_user.id
	flash[:notice] = "Welcome #{@new_user}"
	puts "#{params.inspect}"
	redirect to ('/account')
end

get '/account' do
	erb :account
end

post '/account' do
	#something
end

get '/feed' do
	erb :feed
end

post '/feed' do
	#somthing
end

get '/profile' do
	erb :profile
end

post '/profile' do
	#something
end