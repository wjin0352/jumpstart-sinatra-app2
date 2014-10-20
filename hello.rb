# require 'sinatra'
# require 'sinatra/reloader' if development?

# # the route handler, says client should get the page with url of /hello
# 	get '/hello' do  
# 		"Hello Sinatra!"
# 	end

# 	get '/frank' do
# 		name = "Frank"
# 		"Hello #{name}"
# 	end

# 	# This route contains a named parameter called :name signified by : colon
# 	# Named parameters can go anywhere on a URL, and available in the
# 	# handler as part of the params hash.(hash uses key/value pair system for data storage)
# 	# params hash is automatically created to hold into entered as named 
# 	# parameters on the URL or as paramenter sent via HTML form, great way
# 	# to grab informatoin from a URL
# 	get '/:name' do
# 		name = params[:name]
# 		"Hi there #{name}!"
# 	end

# 	get '/:one/:two/:three' do
# 		"first: #{params[:one]}, second: #{params[:two]}, third: #{params[:three]}"
# 	end

# 	get '/what/time/is/it/in/:number/hours' do
# 		number = params[:number].to_i
# 		time = Time.now + number * 3600
# 		"The Time in #{number} hours will be #{time.strftime('%I:%M %P')}"
# 	end



















