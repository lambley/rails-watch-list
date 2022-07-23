require 'open-uri'
require 'json'

OMDB_KEY = '7ea1ff7f'.freeze

puts "Cleaning database..."
Movie.destroy_all
List.destroy_all
Bookmark.destroy_all

puts "Creating new database from db/seeds.rb"
10.times do
  title = Faker::Movie.title.gsub(/.*(\\u....).*/, '-')
  url = "http://www.omdbapi.com/?t=#{title}&apikey=#{OMDB_KEY}"
  movie_raw = URI.parse(url).open.string
  movie_json = JSON.parse(movie_raw)
  movie = Movie.create!(
    title: movie_json['Title'],
    overview: movie_json['Plot'],
    poster_url: movie_json['Poster'],
    rating: movie_json['imdbRating']
  )
  puts "created movie with id #{movie.id} - #{movie.title}"
end

puts "generating lists"
10.times do
  list = List.create(
    name: Faker::Book.genre
  )
  puts "list #{list.name} generated"
end

puts "generating bookmarks"
20.times do
  bookmark = Bookmark.create(
    comment: Faker::Movie.quote,
    movie_id: Movie.ids.sample,
    list_id: List.ids.sample
  )
  if bookmark.save
    puts "created bookmark #{bookmark.id} for #{Movie.find(bookmark.movie_id).title} and list '#{List.find(bookmark.list_id).name}'"
  end
end
