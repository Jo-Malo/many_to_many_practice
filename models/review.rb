require_relative('../db/sql_runner')

class Review

  attr_reader :id
  attr_accessor :fan_id, :album_id, :rating

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @fan_id = options['fan_id'].to_i
    @album_id = options['album_id'].to_i
    @rating = options['rating']
  end

  def save()
    sql = "INSERT INTO reviews
    (
      fan_id,
      album_id,
      rating
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@fan_id, @album_id, @rating]
    review = SqlRunner.run( sql, values ).first
    @id = review['id'].to_i
  end

  def fan()
    sql = "SELECT * FROM fans WHERE id = $1"
    values = [@fan_id]
    fan_hash = SqlRunner.run(sql, values).first()
    return Fan.new(fan_hash)
  end

  def album()
    sql = "SELECT * from albums WHERE id = $1"
    values = [@album_id]
    album_hash = SqlRunner.run(sql, values).first()
    return Album.new(album_hash)
  end

  def self.all()
    sql = "SELECT * FROM reviews"
    review_hashes = SqlRunner.run(sql)
    reviews = review_hashes.map { |review| Review.new( review ) }
    return reviews
  end

  def self.delete_all()
    sql = "DELETE FROM reviews"
    SqlRunner.run(sql)
  end


end
