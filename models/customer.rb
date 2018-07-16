require_relative('../db/sql_runner.rb')

# [C]initialize; save; update; delete; delete_all;

class Customer

  #TODO attr details

  attr_reader :c_id, :cust_name, :cust_funds
  attr_writer :cust_name, :cust_funds


  def initialize (options)
    @c_id = options['c_id'].to_i if options['c_id']
    @cust_name = options['cust_name']
    @cust_funds = options['cust_funds'] # NB note that the funds is put into the db as a STRING; any future calculations will require conversion to INTEGER
  end

  def save()
    sql = 'INSERT INTO customers
    (cust_name, cust_funds)
    VALUES
    ($1, $2)
    RETURNING c_id;'
    values = [@cust_name, @cust_funds]
    customers = SqlRunner.run(sql, values).first
    @c_id = customers['c_id'].to_i
  end

  def info()
    sql = 'SELECT * FROM customers WHERE c_id = $1;'
    values = [@c_id]
    customer = SqlRunner.run(sql,values)
    result = Customer.new(customer.first)
    return result
  end

  def self.all()
    sql = 'SELECT * FROM customers;'
    all_customers = SqlRunner.run(sql)
    result = all_customers.map{|customer| Customer.new (customer)}
    return result
  end

  def update()
    sql = 'UPDATE customers SET cust_name = $1, cust_funds = $2 WHERE c_id = $3;'
    values = [@cust_name, @cust_funds, @c_id]
    SqlRunner.run(sql,values)
  end

  def delete() # values needed for specificity
    sql = 'DELETE FROM customers WHERE c_id = $1;'
    values = [@c_id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all() # no values needed
    sql = 'DELETE FROM customers;'
    SqlRunner.run(sql)
  end

  def film
    sql = 'SELECT films.* cust_name
        FROM films
            INNER JOIN tickets
              ON films.f_id = tickets.fk_film_id
                WHERE fk_customer_id = $1'
    values = [@c_id]
    films = SqlRunner.run(sql,values)
    result = films.map{|film| Film.new(film)}
    return result
  end

  #want to recover all film objects for customer and count them
  #film method returns an array of film objects, so can use count
  def tickets_purchased
    return film().count
  end

  def purchase_ticket(ticket_object) # here we pass in the ticket object
    return if @cust_funds < ticket_object.film.film_price # First we check the funds are available with return if. Next we apply the 'what is the ticket's film' method (.film). We then apply the .film_price getter method to get the associated film object's price
    @cust_funds -= ticketprice # we then deduct the film price from the customers funds
    update # to save the modified funds associated with the customer. NB how does it now it the Customer update method and not any other linked through???? 
  end


  def pay_for_ticket(ticket)
      return if @funds < ticket.film.price
      @funds -= ticket.film.price
      update
    end


end
