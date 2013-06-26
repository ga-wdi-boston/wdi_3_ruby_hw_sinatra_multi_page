require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
	@movies = []
	movie_links = File.new("movies.csv", "r")
	movie_links.each do |line|
		@movies << line.split(",")[0]
	end
	movie_links.close
	print @movies.inspect
	erb :movies
end

# This should show a single movie
# Goes through movies.cvs until it finds title from equal
#  	to :name, then strips and splits entire line into array
# 	used by movie.erb to create the page
get '/movie/:name' do
	@name = params[:name]
	@info = []
	movie_links = File.new("movies.csv", "r")
	movie_links.each do |line|
		if line.split(",")[0] == @name then
			@info = line.split(",")
		end
	end
	movie_links.close
  	erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
	erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
	movie_links = File.new("movies.csv", "a+")
	@title = params[:title]
	@year = params[:year]
	@director = params[:director]
	@img_link = params[:img_link]
	@revenue = params[:revenue]
	movie_links.puts("#{@title}, #{@year}, #{@director}, #{@img_link}, #{@revenue}")
	movie_links.close
	redirect to("/movie/#{URI::encode(@title)}")
end
