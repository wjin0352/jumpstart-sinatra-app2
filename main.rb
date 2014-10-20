require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require 'slim'
require './song'

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end


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

# this route grabs name entered in URL and stores it in params hash, problem is the info
# in the params hash will be available only for that request, so we store it in session hash
# so it is available for all requests.
get '/set/:name' do
	session[:name] = params[:name]
end

get '/get/hello' do
	"Hello #{session[:name]}"
end

# we enabled sessions in the config block above, now we need a login route handler that 
# displays a view called login that contains a form to be submitted.
get '/login' do
	slim :login
end

# we need to create a handler to deal with a form being submitted from above
post '/login' do
	if params[:username]  == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		slim :login
	end
end

# to log out we destroy the session variable by using clear method for session object, 
# this router will destroy session and redirect user to login page.
get '/logout' do
	session.clear
	redirect to('/login')
end









# set :public_folder, 'assets'

# set :views, 'templates'





















