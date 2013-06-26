require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  movie_file = File.new('movies.csv','r')
  @movies = []
  movie_file.each do |line|
    @movies << line.split(',')
  end
  movie_file.close

  erb :movies
end

# This should show a single movie
get '/movie/:title' do
  @title = params[:title]

  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title         = params[:title]
  @year_released = params[:year_released]
  @director      = params[:director]
  @image_url     = params[:image_url]
  @revenue       = params[:revenue]

  file = File.open('movies.csv','a+')
  file.puts("#{@title},#{@year_released},#{@director},#{@image_url},#{@revenue}")
  file.close

  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end
