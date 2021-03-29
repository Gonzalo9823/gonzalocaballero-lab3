# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

b1 = Beer.create(brand: "Cristal", beer_type: "Lager", alcvol: 5.0)
b2 = Beer.create(brand: "Escudo", beer_type: "Lager", alcvol: 5.0)
b3 = Beer.create(brand: "Kustmann", beer_type: "Torobayo", alcvol: 5.0)
b3 = Beer.create(brand: "Kustmann", beer_type: "Alkoholfrei", alcvol: 0.1)
