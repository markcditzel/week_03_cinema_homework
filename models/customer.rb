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

end
