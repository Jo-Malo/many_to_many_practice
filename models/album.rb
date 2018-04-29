require_relative('../db/sql_runner')

class Album

  attr_reader :id
  attr_accessor :name, :artist, :year

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @artist = options['artist']
    @year = options['year']
  end

  def save()
    sql = "INSERT INTO albums
    (
      name,
      artist,
      year
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@name, @artist, @year]
    album = SqlRunner.run( sql, values).first
    @id = album['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    return Album.map_items(album_hashes)
  end

  def self.map_items(album_hashes)
    result = album_hashes.map {|album_hash| Album.new(album_hash)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

end
