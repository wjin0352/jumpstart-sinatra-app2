require 'dm-core'
require 'dm-migrations'

# part2 - defining my models with datamapper
# Serial type (auto incrementing int)automatically gives a unique key and 
# generates unique id for each row in db

class Song
	# include is similar to require, different in that when we say include 
	# datamapper is a class and::resource is a module in that class
	# include takes all the functions or methods that are inside resource module 
	# and makes them class methods inside the user class.  so we can use those methods

	# property method takes : name of field, type
	# this is datamapper short hand for unique primary key for the database

	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :lyrics, Text
	property :length, Integer
	property :released_on, Date 

	def released_on=date
    super Date.strptime(date, '%m/%d/%Y')
	end

 end

# NOTE:  Every model MUST have a key to be valid, if a 
# model has no key, theres no way to id a resource and no way 
# to update its persistent state within a backend datastore.
# datamapper wil raise an error incomplete model error when
# trying to auto migrate a model with no key declared.
class Contact 
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :body, Text
	property :released_on, Date
	property :email, String
end

module SongHelpers
	def find_songs
		@songs = Song.all
	end

	def find_song
		Song.get(params[:id])
	end

	def create_song
		@song = Song.create(params[:song])
	end
end

helpers SongHelpers


# configure :development do
# DataMapper.setup(:default, 'postgres://localhost/sinatraapp1') 
# # DataMapper.finalize.auto_upgrade!
#  end


configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

# how do we get datamapper to create this database??
# 2 methods to do this --> DataMapper.auto_upgrade!   
# and DataMapper.auto_migrate!
# auto_migrate! will create a brand new database, even if making a small change
# it will clear all data out of database there and reinitialize the db in its initial state
# auto_upgrade! will try and make any changes to the model. 

DataMapper.finalize
# tells DataMapper to update the database with the tables and
# fields that we will eventually create in our models, 
# and then automatically update it if we change anything
# http://datamapper.org/getting-started.html

get '/songs' do
	find_songs
	slim :songs
end

get '/songs/new' do  # sends to a form in new_song  that will send by action="url" to post route /songs 
	halt(401, 'Not Authorized') unless session[:admin]
	@song = Song.new
	slim :new_song
end

get '/songs/:id' do
  @song = find_song
  slim :show_song
end

get '/songs/:id/edit' do
	@song = find_song
	slim :edit_song
end

post '/songs' do   # data sent from from, ends up here and we use the params :song and its id to create new song 
	# and redirect to another route where it will render a view for us with the info.  Since we cannot
	# render a view in post 
	song = create_song
	redirect to("/songs/#{song.id}")
end

put '/songs/:id' do
	song = find_song
	song.update(params[:song])
	redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
	find_song.destroy
	redirect to('/songs')
end

# post '/contact' do
# 		@sample = Song.all
# 		slim :contact
# end

get '/test' do
	@song = Song.all
	slim :new
end










