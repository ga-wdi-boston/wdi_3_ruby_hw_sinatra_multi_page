require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  movies = File.new('movies.csv','r')
  @movies = []
  movies.each do |line|
  @movies << line.split(',')
  end
  movies.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @movie = params[:name]
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]
  @movie =params[:movie]
  f =File.new('movies.csv', 'a+')
  f.puts("#{@title}, #{@movie}")
  f.close
  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end




















