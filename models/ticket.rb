require_relative("../db/sql_runner.rb")

class Ticket

  attr_accessor :t_id, :fk_customer_id, :fk_film_id
  attr_writer :c_id, :f_id

  def initialize(options)
    @t_id = options['t_id'].to_i if options ['t_id']
    @fk_customer_id = options['fk_customer_id'].to_i
    @fk_film_id = options['fk_film_id'].to_i
  end

  def save()
    sql = 'INSERT INTO tickets (fk_customer_id, fk_film_id)
    VALUES ($1, $2)
    RETURNING t_id'
    values = [@fk_customer_id, @fk_film_id]
    tickets = SqlRunner.run(sql,values)[0]
    @t_id = tickets['t_id'].to_i
  end



  def update
    sql = 'UPDATE tickets SET fk_customer_id = $1, fk_film_id = $2 WHERE t_id = $3'
    values = [@fk_customer_id, @fk_film_id, @t_id]
    SqlRunner.run(sql,values)
  end

  # Following functions not yet tested
  # return the film linked to this ticket; the ticket can only be for one film
  #NB you can use the FK for the film as a substitite for the PK in the SQL query
  #NB we select all of the films columns so we can create a new instance of a Film throught he Film.new method
  def film
    sql ='SELECT films.*
    FROM films
    WHERE f_id = $1'
    values = [@fk_film_id]
    film = SqlRunner.run(sql,values).first
    return Film.new(film)
  end

  def customer
    sql = 'SELECT customers.*
    FROM customers
    WHERE c_id = $1'
    values = [@fk_customer_id]
    customer = SqlRunner.run(sql,values).first
    return Customer.new(customer)
  end


  def self.all # no values required
    sql = 'SELECT * FROM tickets'
    results = SqlRunner.run(sql)
    return results.map{|ticket| Ticket.new(ticket)}
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end
  





end
