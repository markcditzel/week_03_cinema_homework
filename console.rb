require_relative('./models/film')
require_relative('./models/customer')
require_relative('./models/ticket')


require( 'pry-byebug' )

#NB check to see how the film price can be entered; e.g., 05.00, 5.00, 5.0 ect)

## CRUD Film ####

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

options3 = {'film_title' => 'Bite Mans Dog3', 'film_price' => '55' }
film3 = Film.new(options3)
film3.save

#p Film.all

### CRUD Customer ###

Customer.delete_all

#NB you can input data directly
customer1 = Customer.new({'cust_name' => 'George Doors', 'cust_funds' => '500'})
customer1.save

customer2 = Customer.new({'cust_name' => 'Bill Windows', 'cust_funds' => '100'})
customer2.save


#customer1.delete
customer2.cust_name = 'Simon Vents'
customer2.update

customer3 = Customer.new({'cust_name' => 'Tom Gutters', 'cust_funds' => '1000'})
customer3.save

#NB we use the preexisting c_id and f_id to be assigned to tp the FK values in ticket

ticket1 = Ticket.new({'fk_customer_id' => customer3.c_id, 'fk_film_id' => film3.f_id})
ticket1.save
#binding.pry

ticket1.fk_customer_id = customer3.c_id
ticket1.update

ticket1.film

ticket1.customer

Ticket.all

Ticket.delete_all

ticket1.delete



# film2.info
#
# #p Customer.all
#
# #p Film.all
#
# #p film3.info
#
# # Film.all

# # customer2.info
# #
# # film3.info
#
# p Customer.all




# nil
