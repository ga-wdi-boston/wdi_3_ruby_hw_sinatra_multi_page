movie_file = File.new('movies.csv', "r")
#title as the key

@movies = {}
# iterates over each line
movie_file.each do |line_in_file|
  # split each of those lines
  movie_data = line_in_file.split(',')
  # title is first element of array
  title = movie_data[0]
  @movies[title] =  movie_data
end
movie_file.close

puts @movies["Up"].inspect