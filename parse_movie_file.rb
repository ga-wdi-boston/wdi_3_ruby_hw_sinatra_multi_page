# Open a file
movie_file = File.new('movies.csv', "r")
# We're going to start 
# by using just title as the key
@movies = {}

# This iterates over EACH LINE of the file that we 
# have opened.
movie_file.each do |line_in_file|
	# Once we have eaach line, we split that by 
	# comma!
	# Citizen Kane,1941,Orson Welles,http://upload.wikimedia.org/wikipedia/en/thumb/c/ce/Citizenkane.jpg/405px-Citizenkane.jpg,1585634
	# s
	split_line= line_in_file.split(",")
	#puts split_line.inspect
	# .inspect lets us see more when we're debugging
	# about what the variable is, etc. 
	# puts title.inspect
	# The title is the first element of the CSV. 
	title = split_line[0]
	@movies[title]=split_line
end
movie_file.close

puts @movies["Fight Club"].inspect
