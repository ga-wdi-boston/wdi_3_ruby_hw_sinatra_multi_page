require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

def get_movie_hash()
# This should list all the movies
  movie_file = File.new('movies.csv', 'r')
  movies = {}
  movie_file.each do |movie_line|
    split_line=movie_line.split(",")

    title = split_line[0]
    movies[title] = split_line
    end
    return movies
end



get '/' do
  @movies = get_movie_hash
  erb :movies
end




# This should show a single movie
get '/movie/:name' do
  @name = params[:name]
  @movies = get_movie_hash

  erb :movie
end




# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title].capitalize
  @year = params[:year]
  @picture = params[:picture]
  @revenue = params[:revenue]

  File.open('movies.csv', 'a') do |file|
    file.write("#{@title},#{@year},#{@picture},#{@revenue}")
  end


  #This will send you to the newly created movie
  redirect to("/movie/#{@title}")
end











