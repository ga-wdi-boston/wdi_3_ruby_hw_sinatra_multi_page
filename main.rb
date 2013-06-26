require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

class Movie
  @movie = {}
end

class Movies

  def index
    @movies = Movie.all
  end

end

# This should list all the movies
get '/' do
  erb :movies
end

get '/movies' do
  erb :movies
end

def get_movie_hash()
  movie_file = File.new('movies.csv', 'r')
  # We're gonna start this by using
  # just title as the key
  movies = {}
  # This iterates over EACH LINE of the fole that we have opened.
  movie_file.each do |line_in_file|
    # Once we have each line, we split that by comma!
    # Citizen Kane,1941,Orson Welles,http://upload.wikimedia.org/wikipedia/en/thumb/c/ce/Citizenkane.jpg/405px-Citizenkane.jpg,1585634
    movie_data_split_by_line = line_in_file.split(',')
    # puts split_line.inspect
    # The title is the first element of the CSV.
    # .inspect lets us see more when we're debugging
    # about what the variable is, etc.
    # puts title.inspect
    title = split_line
    movies[title]=movie_data_split_by_line
  end
  movie_file.close

  # puts @movies["Citizen Kane"].index

end

# # This should show a single movie
get '/movie/:name'
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  @name = params[:name]
  @movies = get_movie_hash
  # If you use an array, you have to go through each array, to try and find the title. With a
  @movie = @movies[@name]
  erb :movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]

  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end

# WORKING ON THE HASH OF MOVIES

# post '/new_movie' do
#   @movies = params[:name]
#   @link = params[:link]
#   f = File.new('links.csv', 'a+')
#   f.puts("#{@link_name},#{@link}")
#   f.close
#   redirect to("/links")
# end

