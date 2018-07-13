require_relative('../db/sql_runner.rb')

class Customer

  #TODO attr details

  attr_writer :cust_name, :cust_funds
  attr_reader

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
                  RETURNING c_id'
    values = [@cust_name, @cust_funds]
    customers = SqlRunner.run(sql, values).first
    @c_id = customers['c_id'].to_i
  end

  def self.delete_all # no values needed
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def delete() # values needed for specificity
    sql = 'DELETE FROM customers WHERE c_id = $1'
    values = [@c_id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = 'UPDATE customers SET cust_name = $1, cust_funds = $2 WHERE c_id = $3'
    values = [@cust_name, @cust_funds, @c_id]
    SqlRunner.run(sql,values)
  end

end
