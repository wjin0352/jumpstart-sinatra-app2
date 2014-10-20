require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require 'slim'
require './song'

get('/styles.css'){ scss :styles }

get '/' do
  @title = "Home"
	slim :home
end

get '/about' do
  @title = "All About This Website"
	slim :about
end

get '/contact' do
  @title = "Contact"
	slim :contact		
end

not_found do
  @title = "Not Found"
  slim :not_found
end





# set :public_folder, 'assets'

# set :views, 'templates'

