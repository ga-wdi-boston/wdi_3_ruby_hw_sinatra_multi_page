class MovieFile
  def self.get_movies
    movie_file = File.new("movies.csv", "r")
    @movies = []
    movie_file.each do |movie_line|
      @movies << movie_line.split(",")
    end
    movie_file.close
    return @movies
  end
end