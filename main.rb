require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

def get_movie_hash()
	# Open a file
	movie_file = File.new('movies.csv', "r")
	# We're going to start 
	# by using just title as the key
	movies = {}
	# This iterates over EACH LINE of the file that we 
	# have opened.
	movie_file.each do |line_in_file|
		# Once we have eaach line, we split that by 
		# comma!
		# Citizen Kane,1941,Orson Welles,http://upload.wikimedia.org/wikipedia/en/thumb/c/ce/Citizenkane.jpg/405px-Citizenkane.jpg,1585634
		# s
		movie_data= line_in_file.split(",")
		#puts split_line.inspect
		# .inspect lets us see more when we're debugging
		# about what the variable is, etc. 
		# puts title.inspect
		# The title is the first element of the CSV. 
		title = movie_data[0]
		movies[title]=movie_data
		# If it were an array. 
		#movies << movie_data
	end
	movie_file.close
	return movies
end 

# This should list all the movies
get '/' do
	# Populate our movie hash. 
	@movies = get_movie_hash	
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
	@name = params[:name]
	# Getting 
	# @movies is now equal to a hash returned 
	# from the function, which reads from the 
	# movie file
	@movies = get_movie_hash
	# If you use an array, you have to go through 
	# each array, to try and find the title
	# With a hash, you can just access it by the key
	# Gives us the value in the hash.
	# @movie = @movies['Psycho'] 
	# Returns 
	@movie = @movies[@name] 
  	erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]

  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end
