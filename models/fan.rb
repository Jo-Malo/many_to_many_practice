require_relative('../db/sql_runner')

class Fan
  attr_reader :id
  attr_accessor :name, :location

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @location = options['location']
  end

  def save()
    sql = 'INSERT INTO fans
    (name, location)
    VALUES
    ($1, $2)
    RETURNING id'
    values = [@name, @location]
    fan = SqlRunner.run( sql, values).first
    @id = fan['id'].to_i
  end

#CLASS METHODS

  def self.all()
    sql = "SELECT * FROM fans"
    fan_hashes = SqlRunner.run(sql)
    return Fan.map_items(fan_hashes)
  end

  def self.map_items(fan_hashes)
    result = fan_hashes.map {|fan_hash| Fan.new(fan_hash)}
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM fans"
    SqlRunner.run(sql)
  end

end
