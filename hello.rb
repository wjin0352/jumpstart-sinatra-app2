require 'sinatra'
require 'sinatra/reloader' if development?

# the route handler, says client should get the page with url of /hello
	get '/hello' do  
		"Hello Sinatra!"
	end

	get '/frank' do
		name = "Frank"
		"Hello #{name}"
	end

















