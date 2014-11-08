require 'sinatra'
require 'data_mapper'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'do_postgres'
require './song'

# Code inside this block is run only once at startup. 
# You can have as many configure blocks as you like in a 
# Sinatra app and they can be placed at any point in the code, 
# but the accepted convention is to use one block and place it 
# near the start of a file

configure :development do
# DataMapper.setup(:default, 'postgres://localhost/sinatraapp1') 
# DataMapper.finalize.auto_upgrade!
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
 end
# To get postgres working locally I had to redownload postgres using postgres.app
# then make sure the paths were correct!!! and check good install
# by creating dbs// psql yourdb  // check notes...

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

# configure :development do
# 	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
# end

# this creates a file called development.db (if it doesnt already exist)
# which stores all database information, now lets create our song class

# the include DataMapper::Resource line is how we make any ruby class
# a DataMapper resource.

# Dont worry where these configure blocks go, they can go anywhere and have multiples
# the convention is to have one config block thats near top of the file
 # end

# configures db for production using postgresql in heroku
# TYPE: heroku config to check DATABASE_URL your app is using to connect to db
# TYPE: heroku pg  OR: heroku addons for info about the databse for your app 
# NOTE: HEROKU_POSTGRESQL_COLOR_URL in app config, will have the URL used for your db

# configure :production do
# 	DataMapper.setup(:default, ENV['DATABASE_URL'])
# end

configure :production do
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/[HEROKU_POSTGRESQL_CHARCOAL_URL]")
end

# IMPORTANT NOTE!: YOU MUST AUTOMIGRATE THIS FIRST BY to create our db tables
# on the terminal, heroku run console, require './main', DataMapper.auto_migrate!

# : heroku logs to find errors, usually if your connected to db, you just need to migrate the data.

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
  @js = "mod.js"
	slim :contact		
end

post '/contact' do
		
		slim :contact
end




not_found do
  @title = "Not Found"
  slim :not_found
end

# login route handler
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





















