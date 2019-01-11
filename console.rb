require ('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Isabel Grant', 'funds' => 20})
customer1.save
customer2 = Customer.new({'name' => 'Richard Shanahan', 'funds' => 300})
customer2.save
customer3 = Customer.new({'name' => 'Mariha Hamid', 'funds' => 40})
customer3.save

film1 = Film.new({'title' => 'Pulp Fiction', 'price' => 7})
film1.save
film2 = Film.new({'title' => 'Death Proof', 'price' => 5})
film2.save
film3 = Film.new({'title' => 'Kill Bill', 'price' => 10})
film3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket4.save
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket5.save

# customer1.delete()
# film1.delete()








binding.pry
nil
