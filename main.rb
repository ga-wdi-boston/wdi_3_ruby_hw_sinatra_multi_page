require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  movie_file = File.new('movies.csv', 'r')
  @movies = []
  movie_file.each do |movie|
    @movies << movie.split(',')
  end
  movie_file.close
  erb :movies
end

# This should show a single movie
get '/movies/:name' do
  @title = params[:name]
  movie_file = File.new('movies.csv', 'r')
  @movie_info = []
  movie_file.each do |movie|
    if movie.split(',')[0] == @title then
      @movie_info = movie.split(',')
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
  movie_file = File.new('movies.csv', 'a+')
  @title = params[:title]
  @year = params[:year]
  @director = params[:director]
  @image_link = params[:image_link]
  @box_office = params[:box_office]
  movie_file.puts("#{@title}, #{@year}, #{@director}, #{@image_link}, #{@box_office}")
  movie_file.close
  #This will send you to the newly created movie
  redirect to("/movies/#{URI::encode(@title)}")
end
