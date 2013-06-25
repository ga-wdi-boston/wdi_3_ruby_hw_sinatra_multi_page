require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  movie_file = File.new('movies.csv', 'r')
  @movie = []
    movie_file.each do |line|
      @movie << line.split(',')
    end
  movie_file.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do

  erb :movie
end


# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]
  @year_of_release = params[:year_of_release]
  @director_name = params[:director_name]
  @image = [:image] # need to import an image (url provided in movies.csv)
  @box_office_revenue = params[:box_office_revenue]


  This will send you to the newly created movie
  redirect to("/movies/#{@title}")

end



