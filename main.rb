require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require 'pry'

set :database, "sqlite3:comic.sqlite3"
set :sessions, true
enable :sessions
use Rack::Flash, sweep: true

get '/' do
	erb :home
end

post '/' do
	#something
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