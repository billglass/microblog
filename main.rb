require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require 'pry'

set :database, "sqlite3:comic.sqlite3"
set :sessions, true
enable :sessions
use Rack::Flash, sweep: true

