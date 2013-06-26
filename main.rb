require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'movie_file'

# This should list all the movies
get '/' do
  @movies = MovieFile.get_movies
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @name = params[:name]
  @movies = MovieFile.get_movies
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]
  @year = params[:year]
  @budget = params[:budget]
  @image = params[:image]
  @director = params[:director]
  movie_file = File.new("movies.csv", "a+")
  movie_file.puts("\n#{@title},#{@year},#{@director},#{@image},#{@budget}")
  movie_file.close
  #This will send you to the newly created movie
  redirect to("/movie/#{@title.gsub(/\s/,'-')}")
end