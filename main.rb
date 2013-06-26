require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  f = File.new('movies.csv', 'r')
  @movies_db = []
  @movie_link = [] #TEST
  f.each do |line|
    parsed_movie = line.split(',')
    parsed_movie << "/movie/#{parsed_movie[0].split.join.downcase}"
    @movies_db << parsed_movie
  end
  f.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  f = File.new('movies.csv', 'r')
  @movies_db = []
  f.each do |line|
    parsed_movie = line.split(',')
    @movies_db << parsed_movie
  end
  f.close

  @movie_titles = []
  @movies_db.each do |movie_data_set|
    @movie_titles << movie_data_set[0].split.join.downcase
  end
  chosen_index = @movie_titles.index(params[:name].split.join.downcase)
  @chosen_movie_array = @movies_db[chosen_index]
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

