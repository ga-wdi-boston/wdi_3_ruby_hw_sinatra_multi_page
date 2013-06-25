require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
 link_file = File.new('movies.csv', 'r')
  @movies = []
  link_file.each do |line|
    movie = line.split(',')
    @movies << movie
  end

  erb :movies
end

# This should show a single movie
get '/movie/:name' do

  # link_file = File.new('movies.csv', 'r')
  # @movies = []
  # link_file.each do |line|
  #   movie = line.split(',')
  #   @movies << movie
  #   params[:name] = movie[0].downcase
  # end

  # params[:name] = @name

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
  @image = params[:image]
  @revenue = params[:revenue]

  f = File.new('movies.csv', 'a+')
  f.puts("#{@title},#{@year},#{@director},#{@image},#{@revenue}")
  f.close

  redirect to("/") #for temp

  #This will send you to the newly created movie
  # redirect to("/movies/#{@title}")
end
