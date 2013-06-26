require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
# This should list all the movies
get '/allmovies' do
  movie_file = File.new('movies.csv','r')
  @movies = []
  movie_file.each do |line|
    @movies << line.split(',')
  end
  movie_file.close
  erb :movies
end

# This should show a single movie
#get '/movie/:name'
#   @name = params[:name]
#   movie_file = File.new('movies.csv','r')
#   loop movie.file.each do |movie|
#     until params[:name] =
#   #how to find 1) Loop through movie file until first thing thta contains movie title matches the title of the movie - what line is it on so i can retrieve info from that line to out put it?
#   erb :movie
# end

# This page should have a form to create a new movie, which will POST to /new_movie
#get '/new_movie' do


  #erb :new_movie
#end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]

  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end
