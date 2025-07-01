movies = {
  :GoneWithTheWind => 1920,
  :StarWars => 1975,
  :ToyStory => 2008,
  :SpaceStuff => 2001,
  :ET => 1981,
}

puts "Movies and their release years:"
movies.each { 
  |name, year| puts "#{year}"
}

puts "Movie release years in an array:"
years = movies.values
puts years

