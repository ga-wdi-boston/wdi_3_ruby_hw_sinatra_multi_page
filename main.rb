require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  @movies = []
  movies_file = File.new('movies.csv', 'r')
  movies_file.each do |movie|
    @movies << movie.split(',')[0]
  end
  movies_file.close
  erb :movies
end

# This should show a single movie being pulled from the movies array
get '/movie/:title' do
  @title = params[:title]
  @info = []
  movies_file = File.new("movies.csv", "r")
  movies_file.each do |line|
    if line.split(',')[0] == @title then
      @info = line.split(',')
    end
  end
    movies_file.close
  erb :movie
end
# Send to create movie entry page
get '/new_movie' do
  erb :new_movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]
  @year = params[:year]
  @director = params[:director]
  @revenue = params[:revenue]
  @image = params[:image]

  movies_file = File.new("movies.csv", "a+")
  movies_file.puts("#{@title}, #{@year}, #{@director}, #{@image}, #{@revenue}")
  movies_file.close

  #This will send you to the newly created movie
  redirect to("/movie/#{URI::encode(@title)}")
end
