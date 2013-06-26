require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?



def get_movie_hash()
  movie_file = File.new('movies.csv', "r")
  #title as the key
  movies = {}
  # iterates over each line
  movie_file.each do |line_in_file|
    # split each of those lines
    movie_data = line_in_file.split(',')
    # title is first element of array
    title = movie_data[0]
    movies[title] = movie_data
  end
  movie_file.close
  return movies
end

# This should list all the movies
get '/' do
  @movies = get_movie_hash
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @name = params[:name]
  @movies = get_movie_hash
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