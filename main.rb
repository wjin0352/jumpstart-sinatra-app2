require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require './song'

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

configure :development do
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
# this creates a file called development.db (if it doesnt already exist)
# which stores all database information, now lets create our song class

# the include DataMapper::Resource line is how we make any ruby class
# a DataMapper resource.

# Dont worry where these configure blocks go, they can go anywhere and have multiples
# the convention is to have one config block thats near top of the file
end

# configures db for production using postgresql in heroku
configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
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







# set :public_folder, 'assets'

# set :views, 'templates'





















