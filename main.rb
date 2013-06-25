require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  list_of_movies = File.new('movies.csv', 'r')
  @movies = []
    list_of_movies.each do |line|
    @movies << line.split(',')
    end
  list_of_movies.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do

  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  @name = params[:name]
  @year = params[:year]
  @director = params[:director]
  @image_link = params[:image_link]
  @box_office = params[:box_office]
  erb :new_movie
  add_movie = File.new('movies.csv', 'a+')
  add_movie.puts("#{@name},#{@year},#{@director},#{@image_link},#{@box_office}")
  add_movie.close
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]

  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end
