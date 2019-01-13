require_relative('../db/sql_runner.rb')

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def save()
  sql =
  "INSERT INTO tickets
  (customer_id, film_id)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@customer_id, @film_id]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
  update_funds()
end

def self.delete_all()
  sql =
  "DELETE FROM tickets"
  SqlRunner.run(sql)
end

def delete()
  sql =
  "DELETE FROM tickets
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.select()
  sql =
  "SELECT * FROM tickets"
  result = SqlRunner.run(sql)
  return result.map {|ticket| Ticket.new(ticket)}
end

def update()
  sql =
  "UPDATE tickets
  SET (customer_id, film_id)
  = ($1, $2)
  WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

# def update_funds()
#   sql =
#   "UPDATE customers
#   INNER JOIN films
#   ON films.id = tickets.film_id
#   INNER JOIN customers
#   ON customers.id = tickets.customer_id
#   SET (customers.funds)
#   = (customers.funds - films.price)
#   WHERE tickets.id = $1"
#   values = [@id]
#   SqlRunner.run(sql, values)
# end

def new_fund_value()
   sql = "SELECT * FROM tickets
   INNER JOIN films on films.id = tickets.film_id
   INNER JOIN customers ON customers.id = tickets.customer_id
   WHERE tickets.id = $1"
   values = [@id]
   result = SqlRunner.run(sql, values).first
   return result['funds'].to_i - result['price'].to_i
end

def update_funds()
   new_funds = self.new_fund_value()
   sql = "UPDATE customers SET funds = $1 WHERE id = $2"
   values = [new_funds, @customer_id]
   SqlRunner.run(sql, values)
 end

end
