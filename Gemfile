source 'https://rubygems.org'
gem 'sinatra', "1.3.2"
gem "slim"
gem "sass"
gem "dm-core"
gem "dm-migrations"
gem "thin"
gem 'shotgun', "0.9"
gem 'sinatra-reloader', '~> 1.0'
gem "data_mapper", "1.2.0"
# gem "dm-postgres-adapter", "1.2.0"
# gem "pg", "0.13.2"


group :test do
	gem 'rerun', '~> 0.9.0'
	gem "rspec", "2.10.0"
	gem "capybara", "1.1.2"
	gem "cucumber", "1.2.1"
end

group :development do	
	gem "dm-postgres-adapter", :group => :development
	# gem "dm-sqlite-adapter", :group => :development
end

group :production do
	gem "pg", :group => :production
	gem "dm-postgres-adapter", :group => :production
end








