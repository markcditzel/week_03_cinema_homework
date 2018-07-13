require_relative("../db/sql_runner.rb")

# CREATE - initialise and save methods
# READ - Film.all
# UPDATE - update method#
# DELETE - delete single and all


class Film

  #Add Attr settings here
  # we need to write to film_title and film_price when we create them in the console
  attr_reader :film_title, :film_price
  attr_writer :film_title, :film_price

# the iniialise Class method will take an array from the database when we request the primary key from the database
#this is as the databse returns an array of hases, which we then retrive a single hash containing the id key-associated values
#we use options as a holder for the input hash
#we user input data to create a new instance object of the classe by feeding it a hash of all the data TO the object
#the instance object will also automatically receive a hash contianing the primary key FROM the database
  def initialize(options)
    # when the user creates the Film object we do not provide it wiht the id (aka the primary key)
    # this is because once the known user data is provided and SAVED to the db, we use coud in the SAVE method to return the newly created PK id back into the Film object
    # NB that the keys associated with the hash are strings - hence ['id'] and ['film_title']
    # we are assigned the key values from a hash to their appropraite object instance variables
    @f_id = options['f_id'].to_i if options['f_id']
    @film_title = options['film_title']
    @film_price = options['film_price']
  end

  #NEXT THINK CRUD

  #Create = combo of initialise and save to db; with save completing the object by returning the

  #the save method aims to take the info provided by the USER and put them into the db
  def save()
    #here the user does NOT provide the f_id PK
    sql = 'INSERT INTO films
              (film_title, film_price)
                VALUES
                  ($1, $2)
                    RETURNING f_id'
    values = [@film_title, @film_price]
    #now we want to use sql_runner to both WRITE the user provided inputs TO the db and READ the db-generated PK FROM the db; and then assign that PK to the objects @f_id instance variable
    films = SqlRunner.run(sql, values).first
    #Sql_runner will return an array of hashes; we use the first method to pull out a single hash, which is then assigned to the film variable
    @f_id = films['f_id'].to_i
    # the single hash object contains the entire row's data; so we need to extract just the f_id to assign it to the objects instance variable @f_id
  end

  #delete all method Class method
  #this acts on the Class object
  def self.delete_all()
    sql = 'DELETE FROM films'
    # this does not require any values as we do not need to specify anyting specific about any particular instance of the class's objects
    SqlRunner.run(sql)
  end

  # this deletes a specific object
  def delete()
    sql = 'DELETE FROM films WHERE f_id = $1'
    values = [@f_id]
    SqlRunner.run(sql,values)
  end

  def self.delete_all()
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end  

  def update()
    sql = 'UPDATE films SET film_title = $1, film_price = $2 WHERE f_id = $3'
    values = [@film_title, @film_price, @f_id]
    SqlRunner.run(sql,values)
  end

  #this should return all the information about a film (all columns selected) from the films tables
  #this is a Class method
  #it does not require any values as we are not specifying any particular rows/objects
  #to call this function = Film.all
  def self.all()
    sql = 'SELECT * FROM films'
    all_films = SqlRunner.run(sql) # an array of hashes
    result = all_films.map {|film| Film.new (film)}
    return result
  end









end
