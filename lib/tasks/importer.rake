require "csv"

namespace :importer do


  desc 'import movies.csv'
  task import_movies: :environment do

    CSV.open("movies.csv", 'r', {encoding: 'UTF-8'}).to_a.each_with_index do |row_arr, index|
      if index > 0
        name = row_arr[0]
        description = row_arr[1]
        year = row_arr[2]
        director = row_arr[3]
        actor = row_arr[4]
        city = row_arr[5]
        country = row_arr[6]

        movie = Movie.find_or_create_by(name: name, description: description, year: year.to_i, director: director)
        actor = Actor.find_or_create_by(name: actor)
        location = Location.find_or_create_by(city: city, country: country)

        MovieActor.create(movie_id: movie.id, actor_id: actor.id)
        MovieLocation.create(movie_id: movie.id, location_id: location.id)
      end
    end

    puts "Movies is Imported"
  end
end
