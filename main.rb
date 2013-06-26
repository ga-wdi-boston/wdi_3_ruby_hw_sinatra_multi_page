require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  @movies = []
  movies_file = File.new('movies.csv', 'r')
  movies_file.each do |title|
    @movies << title.split(',')
  end
  movies_file.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @name = params[:name]
  @single_movie = []
  movies_file = File.new('movies.csv', 'r')
  movies_file.each do |title|
    title.split(',')
    # Identifying the name of the movie
    if title.split(',')[0] == @name
      then @single_movie = title.split(',')
    end
  end

  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]
  @year = params[:year]
  @director = params[:director]
  @image_url = params[:image_url]
  @box_office = params[:box_office]
  movies = File.new('movies.csv', 'a+')
  movies.puts "#{@title},#{@year},#{@director},#{@image_url},#{@box_office}"
  movies.close

# Sends user to newly created movie page
  redirect to ("/movie/#{URI::encode(@title)}")

end
