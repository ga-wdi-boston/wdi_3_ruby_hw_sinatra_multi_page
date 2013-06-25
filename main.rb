require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  @movies = []
  movie = File.new('movies.csv', 'r')
  movie.each do |title|
    @movies << title.split(',')
  end
  movie.close
   erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @name = params[:name]
  @info = []
  erb :movie
end



# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end


# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  movie_title = File.new('movies.csv', 'a+')
  @title = params[:title]
  @year = params[:year]
  @director = params[:director]
  @link = params[:link]
  @revenue = params[:revenue]
  movie_title.puts("#{@title}, #{@year}, #{@director}, #{@link}, #{@revenue}")
  movie_title.close
  redirect to ("/movies/#{URI::encode(@title)}")

end

  #This will send you to the newly created movie
  #redirect to("/movies/#{@title}")




