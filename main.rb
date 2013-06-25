require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?



# This should list all the movies
get '/' do
  @titles = []
  movie_file = File.open('movies.csv', 'r') do |file|
    file.each_line do |line|
      @titles << line.split(',')[0]
    end
  end
  erb :movies
end

# This should show a single movie
get '/movie/:name' do
  @name = params[:name]
  @info = []
  movie_file = File.open('movies.csv', 'r') do |file|
    file.each_line do |line|
      @info = line.split(',')
      if @info[0] == @name
        break
      end
    end
  end
  erb :movie
end

# This page should have a form to create a new movie, which will POST to /new_movie
get '/new_movie' do
  erb :movie
end

# Create a new movie by sending a POST request to this URL
post '/new_movie' do
  @title = params[:title]
  @info = [@title, params[:year], params[:director], params[:img_link], params[:revenue]]
  puts "INFO IS #{@info}"
  movie_file = File.open('movies.csv', 'a+') do |file|
    file.puts("#{@info[0]},#{@info[1]},#{@info[2]},#{@info[3]},#{@info[4]}")
  end

  #This will send you to the newly created movie
  redirect to("/movie/#{@title}")
end

