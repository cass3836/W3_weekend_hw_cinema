require_relative('../db/sql_runner.rb')

class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds']
end


def save()
  sql =
  "INSERT INTO customers
  (name, funds)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@name, @funds]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def self.delete_all()
  sql =
  "DELETE FROM customers"
  SqlRunner.run(sql)
end

def delete()
  sql =
  "DELETE FROM customers
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.select()
  sql =
  "SELECT * FROM customers"
  result = SqlRunner.run(sql)
  return result.map {|customer| Customer.new(customer)}
end

def update()
  sql =
  "UPDATE customers
  SET (name, funds)
  = ($1, $2)
  WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def films()
  sql =
  "SELECT films.* FROM films
  INNER JOIN tickets
  ON tickets.film_id = films.id
  WHERE tickets.customer_id = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  return result.map {|film| Film.new(film)}
end

# Buying tickets should decrease the funds of the customer by the price
# Check how many tickets were bought by a customer
# Check how many customers are going to watch a certain film
end
