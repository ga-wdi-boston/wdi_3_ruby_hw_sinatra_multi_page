require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  @movies = ["http://upload.wikimedia.org/wikipedia/en/thumb/c/ce/Citizenkane.jpg/405px-Citizenkane.jpg,1585634",
    "http://upload.wikimedia.org/wikipedia/en/8/88/Img_kingkong1.jpg,1700000",
    "http://upload.wikimedia.org/wikipedia/en/d/de/Bvmovieposter.jpg,8551228",
    "http://upload.wikimedia.org/wikipedia/commons/e/e5/Vertigomovie.jpg,14000000",
    "http://upload.wikimedia.org/wikipedia/en/f/fc/Fight_Club_poster.jpg,100900000",
    "https://upload.wikimedia.org/wikipedia/en/b/b9/Psycho_%281960%29.jpg",
    "http://upload.wikimedia.org/wikipedia/en/2/21/ThirdManUSPoster.jpg,277549",
    "http://upload.wikimedia.org/wikipedia/commons/9/9d/Casablanca%2C_title.JPG",
    "http://upload.wikimedia.org/wikipedia/commons/d/d6/Rearwindowposter.jpg,36764313",
    "http://upload.wikimedia.org/wikipedia/en/9/9e/Rebel_without_a_cause432.jpg,4500000"]
  erb :movies
end

# This should show a single movie
get '/movie/:name'
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]

  #This will send you to the newly created movie
  redirect to("/movies/#{@title}")
end
