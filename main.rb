require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  movie = File.new('movies.csv', 'r')
  @movies = []
  movie.each do |title|
    @movies << title.split(',')
  end
  movie.close
    erb :movies
end

# This should show a single movie
get '/movie/:name' do
  erb :movie
end

get '/new_movie' do
  erb :new_movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do

  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @movie_title = params[:title]
  @movie = paramas[:movie]
  movie_title = File.new('movies.csv', 'a+')
  movie_title.puts("#{@new_movie}, #{@movie}")
  movie_title.close
  redirect to ("/movies")

end

  #This will send you to the newly created movie
  #redirect to("/movies/#{@title}")

post '/navigate' do
  case params[:destination].downcase
    when "new movie" then redirect to("/new_movie")
    when "movies" then redirect to ("/")
  end
  redirect to("/")
end




