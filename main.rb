require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  movie_file = File.new('movies.csv', 'r')
  @movies = []
  movie_file.each do |line|
    @movies << line.split(',')
  end
  movie_file.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @movie_name = params[:name]
  @movies = []
  movie_file = File.new('movies.csv', 'r')
  movie_file.each do |line|
      if line.split(",")[0] == @movie_name then
        @movies = line.split(",")
      end
  end
  movie_file.close
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @movie_name = params[:name]
  @year = params[:year]
  @director = params[:director]
  @img = params[:img]
  @box_office = params[:box_office]
  movie_file = File.new("movies.csv", "a+")
  movie_file.puts("#{@movie_name},#{@year},#{@director},#{@img},#{@box_office}")
  movie_file.close
  #This will send you to the newly created movie
  redirect to("/movie/#{URI::encode(@movie_name)}")
end
