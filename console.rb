require_relative('./models/film')
require( 'pry-byebug' )

#check to see how the film price can be entered; e.g., 05.00, 5.00, 5.0 ect)

Film.delete_all # this prevents accumulating entries of the same film whenever runnig console.

options1 = {'film_title' => 'Man Bites Dog', 'film_price' => '5' }
film1 = Film.new (options1)
#now save the new Film instance object and check to see if f_id is assigned to the database
film1.save
film1.delete

options2 = {'film_title' => 'Man Bites Dog2', 'film_price' => '5' }
film2 = Film.new(options2)
film2.save

film2.film_title = 'Dog Bites Man2'
film2.update

film2.film_price = '11'
film2.update

binding.pry
nil
