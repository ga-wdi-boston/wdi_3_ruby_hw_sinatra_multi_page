require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  list_file = File.new('movies.csv', 'r')
  @movies_list = []
  list_file.each do |movie|
    @movies_list << movie.split(',')
  end
  list_file.close
  erb :movies
end

# This should show a single movie
get '/movie/:title' do
  @title = params[:title]
  @details = []
  list_file = File.new('movies.csv', 'r')
  list_file.each do |movie|
    if movie.split(',')[0] == @title then
      @details = movie.split(',')
  end
end
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  # @title = params[:title]
  # @year = params[:year]
  # @director = params[:director]
  # @image = params[:image]
  # @revenue = params[:revenue]

  # f = File.new('movies.csv', 'a+')
  # f.puts("#{@title},#{@year},#{@director},#{@image},#{@revenue}")
  # f.close
  # redirect to('/')
  erb :new_movie
end

  #   @link_name = params[:name]
  # @link = params[:link]
  # f = File.new('links.csv', 'a+')
  # f.puts("#{@link_name},#{@link}")
  # f.close
  # redirect to("/links")
#   erb :movie
# end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  f = File.new('movies.csv', 'a+')
  @title = params[:title]
  @year = params[:year]
  @director = params[:director]
  @image = params[:image]
  @revenue = params[:revenue]
  f.puts("#{@title},#{@year},#{@director},#{@image},#{@revenue}")
  f.close
  redirect to("/movie/#{URI::encode(@title)}")

  #This will send you to the newly created movie
  #redirect to("/movies/#{@title}")
end

