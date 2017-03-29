# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer = Customer.create({
  name: 'DDF',
  active: true
})

User.create({
  name: 'Fred',
  email: 'fred.wuerges@gmail.com',
  password: '1234567',
  password_confirmation: '1234567',
  customer_id: customer.id,
  confirmed_at: DateTime.now
})