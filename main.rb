require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?


# This should list all the movies
get '/movies' do
  movies_file = File.new('movies.csv', 'r')
  @movies = []
  movies_file.each do |movie|
    @movies << movie.split(',')[0]
  end
  movies_file.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @name = :name
  movie_file = File.new('movies.csv', 'r')
  @move_info = []
  movie_file.each do |movie|
    if line.split(',')[0] == @name
      @movie_info = line.split(',')
    end
    movie_file.close
  end
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :movie
  @title = params[:title]
  @year = params[:year]
  @director = params[:director]
  @image = parm[:image]
  @revenue = params[:revenue]

end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]

  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end
