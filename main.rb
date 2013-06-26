require 'pry'
require 'sinatra' #notes - where does sinatra actually start?
require 'sinatra/reloader' if development?
# This should list all the movies

#def get_movie_hash ()
#movie_file =

get '/allmovies' do
  movie_file = File.new('movies.csv','r') #creating variable that opens file
  @movies = []
  movie_file.each do |line|
    @movies << line.split(',')
  end
  movie_file.close
  erb :movies
end


#if i had decided to treat @movies as hash
# @movies = {}
#movie_file.each do |movie_line|
  #split_line=line_in_file.split(",")
  #puts split_line.inspect
  #title = split_line[0]
  #puts title
  #@movies[title] = split_line    #split line is the array for each movie
#end
#movie_file.close   #always have to close files after we use them

# This should show a single movie
  get '/movie/:name' do
   @name = params[:name]
   @single_movie = []
   movie_file = File.new('movies.csv','r')
   movie.file.each do |title|
    if title.split(',')[0] == @name
      then @single_movie = title.split(',')
    end
  end
  #got some great help from corbin
# @name = params[:name]
# @movies = get_movie_hash
  # @movie = @movies[@name] replaces all the repeated iteration code


  # how to find 1) Loop through movie file until first thing thta contains movie title matches the title of the movie - what line is it on so i can retrieve info from that line to out put it?
   end
   erb :movie
 end

# This page should have a form to create a new movie, which will POST to /new_movie
#get '/new_movie' do


  #erb :new_movie
#end

# Create a new movie by sending a POST request to this URL
get '/new_movie' do
  erb: :new_movie

post '/new_movie' do
  @title = params[:title]
  @year = params[:year]
  @director = params[:director]
  @image_url = params[:image_url]
  @box_office = params[:box_office]
  movies = File.new('movies.csv', 'a+')
  movies.puts "#{@title}, #{year}, #{director}, #{@image_url}, #{@box_office}"
  movies.close
  #This will send you to the newly created movie
  redirect to("/movie/#{URI::encode(@title)}")
end


