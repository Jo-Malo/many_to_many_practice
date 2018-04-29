require_relative('../models/fan.rb')
require_relative('../models/album.rb')
require_relative('../models/review.rb')

require( 'pry' )

Review.delete_all()
Album.delete_all()
Fan.delete_all()

fan1 = Fan.new({ 'name' => 'Mary Marshall', 'location' => 'Dallas' })
fan1.save()
fan2 = Fan.new({ 'name' => 'Tony Nutmeg', 'location' => 'Pokipsy' })
fan2.save()
fan3 = Fan.new({ 'name' => 'Flora Sheep', 'location' => 'Glasgow' })
fan3.save()

album1 = Album.new({ 'name' => 'Let it Bleed', 'artist' => 'The Rolling Stones', 'year' => '1969' })
album1.save()
album2 = Album.new({ 'name' => 'Call me', 'artist' => 'Al Green', 'year' => '1973' })
album2.save()

review1 = Review.new({ 'fan_id' => fan1.id, 'album_id' => album1.id, 'rating' => '8' })
review1.save()
review2 = Review.new({ 'fan_id' => fan2.id, 'album_id' => album1.id, 'rating' => '9'})
review2.save()
review3 = Review.new({ 'fan_id' => fan1.id, 'album_id' => album2.id, 'rating' => '6'})
review3.save()
review4 = Review.new({ 'fan_id' => fan3.id, 'album_id' => album2.id, 'rating' => '10'})
review4.save()

binding.pry
nil
