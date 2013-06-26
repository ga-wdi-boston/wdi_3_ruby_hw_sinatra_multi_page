require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  movie_file = File.new('movies.csv', 'r')
  @movies = []
  movie_file.each do |line|
    @movies << line.split(',')
  end
  movie_file.close
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @name = params[:name]
  movie_file = File.new('movies.csv', 'r')
  @movie = []
  movie_file.each do |line|
    if @name == line.split(',')[0]
      @movie = line.split(',')
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
  @box_office = params[:box_office].split(',').join('')
  movie_file = File.new('movies.csv', 'a+')
  movie_file.puts("#{@title},#{@year},#{@director},#{@image_url},#{@box_office}")
  movie_file.close
  redirect to("/movie/#{URI::encode(@title)}")
end
