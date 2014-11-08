Move your static files(css/js) into a folder named public. Sinatra looks there with default settings.  Static files are served from the ./public directory. You can specify a different location by setting the :public_folder option:
	set :public_folder, File.dirname(__FILE__) + '/static'



POSTGRESQL DB using DataMapper SINATRA

Use postgres.app site to download it, least headache, follow instructions for path etc..

To check if setup was successful go terminal type   :   created mydb
If there was no response you’re good to go, any other response and you need to reinstall the right way!(check paths)
http://www.postgresql.org
http://postgresapp.com/documentation/install.html
To destroy it type:    dropdb mydb

To access database type :   psql mydb

————————————————————————————————————————


REMEMBER TO AUTO MIGRATE to setup your database initially!!!

Interacting with Song class in your ruby app and database in IRB 

:	irb
:	require ‘./main’  			# or what ever file that class is in

: 	Song.auto_migrate!
DataMapper has a brilliant plugin called automigrations. This basically takes the properties listed in the Ruby class and creates the relevant table and columns for you. This is the first task before we can start interacting with the database:  But know that auto_migrate if done again will delete all your data! use auto_update instead

Now we can do CRUD operations Using DataMapper methods!!!

:  song = Song.new

:  song.save

:  song.title = “my way”

:  song.save

or do it all at once type   :   Song.create(title: "Come Fly With Me", lyrics: "Come fly with me, let's fly, let's fly away ... .", length: 199, released_on: Date.new(1958,1,6))

The create will make and save all at once.



:  Song.all  #easiest way to retrieve all properties in db

:  Song.all.reverse

:  Song.get(1) #gets id 1

:  Song.first  # first song or Song.last

:  myway = Song.first(title: “My Way”)

:  myway.length

:  myway.update(length: 275)  	#update will change it and save to db

:  Song.create(title: “one less”

:  Song.last.destroy


--------------------------------------------------------------------------

DEPLOYING TO HEROKU WITH POSTGRESQL

git init…etc

Create a config.ru file, which is a standard convention that Heroku looks for.

		# config.ru

		require './app'
		run Sinatra::Application

Create the app in terminal :  heroku create
	# that also makes a remote repo for you called heroku 
	# to rename your app :  heroku apps:rename name

Deploy your code :  git push heroku master
			     :  heroku open

Info about app	     :  heroku logs

Use a Procfile, a text file in the root directory of your application, to explicitly declare what command 	should be executed to start your app.

	The Procfile in the example app you deployed looks like this:

	web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
	This declares a single process type, web, and the command needed to run it. The nameweb is important 	here. It declares that this process type will be attached to the HTTP routing stack of Heroku, and receive 	web 	traffic when deployed.

	Procfiles can contain additional process types. For example, you might declare one for a background 	worker process that processes items off of a queue.



IMPORTANT!!! YOU MUST AUTO MIGRATE TO SET UP THE DATABASE INITIALLY!! 

One last point to remember is to create the database on Heroku’s servers, since the database we’re using only exists locally. To do this, we need to use Heroku’s console:

$ heroku run console

This works just like an IRB session. We require our main.rb file and run the same command we used in the section called “Migrations” in Chapter 3 to create the database table:

> require './main'
> DataMapper.auto_migrate!

Now if you go to the live website at http://yourappname.herokuapp.com/songs, everything should be working as it does on our local version.

 





APP SCALING

	Right now, your app is running on a single web dyno. Think of a dyno as a lightweight container that runs 	the command specified in the Procfile.

	You can check how many dynos are running using the ps command:

	$ heroku ps
	=== web (1X): `bundle exec unicorn -p $PORT -c ./config/unicorn.rb`
	web.1: up 2014/07/07 12:42:34 (~ 23m ago)
	Having only a single web dyno running will result in the dyno going to sleep after one hour of inactivity. 	This causes a delay of a few seconds for the first request upon waking. Subsequent requests will perform 	normally.

	To avoid this, you can scale to more than one web dyno. For example:

	$ heroku ps:scale web=2
	For abuse prevention, scaling the application may require account verification. If your account has not 	been verified, you will be directed to visit the verification site.

	For each application, Heroku provides 750 free dyno-hours. Running your app at 2 dynos would exceed 	this free, monthly allowance, so scale back:

	$ heroku ps:scale web=1

DATA BASE LOCAL SETUP
https://devcenter.heroku.com/articles/heroku-postgresql#local-setup

DATABASE TO YOUR HEROKU APP
Check what add ons you have, :  heroku addons
Listing config vars for your app will show URL that your app is using to connect to db, DATABASE_URL

	      :	 heroku config
	=== polar-inlet-4930 Config Vars
	DATABASE_URL:                postgres://xx:yyy@host:5432/d8slm9t7b5mjnd
	HEROKU_POSTGRESQL_BROWN_URL: postgres://xx:yyy@host:5432/d8slm9t7b5mjnd
Create new Database
 heroku addons:add heroku-postgresql:hobby-dev

# configures db for production using postgresql in heroku
# TYPE: heroku config to check DATABASE_URL your app is using to connect to db
# TYPE: heroku pg  OR: heroku addons for info about the databse for your app 
# NOTE: HEROKU_POSTGRESQL_COLOR_URL in app config, will have the URL used for your db





Primary Database and multiple dbs
	Heroku recommends using the DATABASE_URL config var to store the location of your primary database. 			In single-database setups your new database will have already been assigned 							aHEROKU_POSTGRESQL_COLOR_URL config with the accompanyingDATABASE_URL. You may verify 		this via heroku config and verifying the value of both HEROKU_POSTGRESQL_COLOR_URL and 			DATABASE_URLwhich should match.

On apps with multiple databases, you can set the primary database like so:

	$ heroku pg:promote HEROKU_POSTGRESQL_RED
	Promoting HEROKU_POSTGRESQL_RED_URL to DATABASE_URL... done




Logging

If your application/framework emits logs on database access, you will be able to retrieve them through Heroku’s log-stream:

$ heroku logs -t
To see logs from the database service itself you can also use heroku logs but with the -p postgres flag indicating that you only wish to see the logs from PostgreSQL.

$ heroku logs -p postgres -t





 



