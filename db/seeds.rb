# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

brand1 = Brand.create(name: "Cristal")
brand2 = Brand.create(name: "Escudo")
brand3 = Brand.create(name: "Kustmann")

beer1 = Beer.create(brand: brand1, beer_type: "Lager", alcvol: 5.0)
beer2 = Beer.create(brand: brand2, beer_type: "Lager", alcvol: 5.0)
beer3 = Beer.create(brand: brand3, beer_type: "Torobayo", alcvol: 5.0)
beer3 = Beer.create(brand: brand3, beer_type: "Alkoholfrei", alcvol: 0.1)

user1 = User.create(first_name: "Gonzalo", last_name: "Caballero", email: "gacaballero@miuandes.cl")

review1 = Review.create(text: "Muy buena!", rating: 10.0, user: user1, beer: beer1)
review2 = Review.create(text: "No tan rica", rating: 4.2, user: user1, beer: beer3)
