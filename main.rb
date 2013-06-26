require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# This should list all the movies
get '/' do
  link_file = File.new('movies.csv', 'r')
  @movies = []
    link_file.each do |line|
      @movies << line.split(',')
    end
  link_file.close
  erb :movies
  end

# This should show a single movie
get '/movie/:name' do
  link_file = File.new('movies.csv', 'r')
  @name = params[:name]
  @one_movie = []
    link_file.each do |line|
      if line.split(',')[0] == @name
        @one_movie = line.split(',')
      end
    end
    #link_file.close
    erb :movie
  end

# This page should have a form to create a new movie, which will POST to /new_movie
#get '/new_movie' do
 # erb :new_movie
#end

# Create a new movie by sending a POST request to this URL
   post '/new_movie' do
     @title = params[:title]
     @year_of_release = params[:year_of_release]
     @director_name = params[:director_name]
     @image = params[:image]
     @box_office_revenue = params[:box_office_revenue]

     f = File.new('movies.csv', 'a+')
     f.puts ("#{title}, #{year_of_release}, #{director_name},
            #{image}, #{box_office_revenue}")
    f.close

 This will send you to the newly created movie
   redirect to("/movie/#{URI::encode(@title)}")

end