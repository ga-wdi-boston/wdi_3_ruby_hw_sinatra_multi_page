require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

#movie titles
#function that allows me to display movies



# This should list all the movies
get '/' do                             #hit on homepage
  @movies = File.new('movies.csv')
  erb :home
end

# This should show a single movie
get '/movie/:name' do
  # @movie = myMovies.new
  # @movie.get_all_titles
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

      # class myMovies
      #   def initialize
      #     @movie_titles = []
      #   end

      #   def get_all_titles
      #     @movie_titles.each do |title|
      #       p |title|
      #     end
      #   end
      # end