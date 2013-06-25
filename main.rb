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

binding.pry


# This should show a single movie
get '/movies/:name' do
  [@movies_list][0] = params[:title]
  [@movies_list][1] = params[:year]
  [@movies_list][2] = params[:director]
  [@movies_list][3] = params[:image]
  [@movies_list][4] = params[:revenue]

  # @title = [@movies_list][0]
  # @year = [@movies_list][1]
  # @director = [@movies_list][2]
  # @image = [@movies_list][3]
  # @revenue = [@movies_list][4]

  erb :movie
end



# # This page should have a form to create a new movie, which will POST to /new_movie
# get '/new_movie' do
#   erb :movie
# end

# # Create a new movie by sending a POST request to this URL
# post '/new_movie' do
#   @title = params[:title]

#   #This will send you to the newly created movie
#   redirect to("/movies/#{@title}")
# end

