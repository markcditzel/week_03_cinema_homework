require_relative("../db/sql_runner.rb")

class Ticket

  attr_accessor :t_id, :fk_film_id, :fk_customer_id
  attr_writer :t_id, :c_id, :f_id

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

## Following functions not yet tested

  def update
    sql = 'UPDATE tickets SET (fk_customer_id, fk_film_id)
    VALUES ($1, $2) WHERE t_id = $3'
    values = [@fk_customer_id, @fk_film_id, @t_id]
    SqlRunner.run(sql,values)
  end

  def film #
    sql ='SELECT films.*
      FROM films
        INNER JOIN films'

  end

  def customer


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
