require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  list_file = File.new('movies.csv', 'r')
  @movies_list = []
  list_file.each do |movie|
    @movies_list << movie.split(',')
  end
  list_file.close
  erb :movies
end


# This should show a single movie
get '/movie/:name'
  erb :movie
end

# # This page should have a form to create a new movie, which will POST to /new_movie
# get '/new_movie' do
#   erb :movie
# end

# # Create a new movie by sending a POST request to this URL
# post '/new_movie' do
#   @title = params[:title]

#   #This will send you to the newly created movie
#   redirect to("/movies/#{@title}")
# end

