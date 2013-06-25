require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  erb :movies
end

# This should show a single movie
get '/movie/:name'
  movie_file = File.new('movies.csv', 'r')
  @movie = []
    movie_file.each do |line|
      @movie << line.split(,)
    end
    movie_file.close
    erb :movie
end

# get '/links' do
#   link_file = File.new('links.csv', 'r')
#   @links = []
#   link_file.each do |line|
#     @links << line.split(',')
#   end
#   link_file.close
#   erb :links
# end


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
