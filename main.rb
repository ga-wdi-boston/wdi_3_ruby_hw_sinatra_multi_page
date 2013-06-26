require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  list_of_movies = File.new('movies.csv', 'r')
  @movies = []
  list_of_movies.each do |line|
    @movies << line.split(',')
  end
  list_of_movies.close
  erb :movies
 end

 # This should show a single movie
 get '/movie/:name' do
  @name = params[:name]
  list_of_movies = File.new('movies.csv', 'r')
  @movie = []
  list_of_movies.each do |line|
    if line.split(',')[0] == @name
      @movie << line.split(',')
    end
  end
  @movie.flatten!
  list_of_movies.close
  erb :movie
 end

get '/new_movie' do
  erb :new_movie
end


post '/new_movie' do
  @title = params[:title]
  @year_released = params[:year_released]
  @director_name = params[:director_name]
  @image_link = params[:image_link]
  @box_office_revenue = params[:box_office_revenue]
  f = File.new('movies.csv', 'a+')
  f.puts("#{@title},#{@year_released},#{@director_name},#{@image_link},#{@box_office_revenue}")
  f.close
  #This will send you to the newly created movie
  redirect to("/movie/#{URI::encode(@title)}")
end





