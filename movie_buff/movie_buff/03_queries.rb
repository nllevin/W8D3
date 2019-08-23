def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:id, :title)
    .joins(:actors)
    .where(actors: { name: those_actors })
    .group(:id)
    .having('COUNT(movies.id) = ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .group('decade')
    .order('SUM(movies.score) / COUNT(movies.id) DESC')
    .limit(1)
    .pluck('(movies.yr / 10 * 10) AS decade')
    .first
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery

  Actor
    .joins(:castings)
    .where([<<-SQL, name: name])
      castings.movie_id IN (
        SELECT
          movies.id
        FROM
          movies
        JOIN
          castings ON castings.movie_id = movies.id
        JOIN
          actors ON actors.id = castings.actor_id
        WHERE
          actors.name = :name
      )
      AND actors.name != :name
    SQL
    .distinct
    .pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .left_outer_joins(:castings)
    .where(castings: { movie_id: nil })
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  
  name_ex = "%#{ whazzername.split("").join("%") }%"
  Movie
    .joins(:actors)
    .where("actors.name ILIKE ?", name_ex)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
    .select('MAX(yr) - MIN(yr) AS career, actors.id, actors.name')
    .joins(:movies)
    .group(:id)
    .order('career DESC')
    .limit(3)
end
