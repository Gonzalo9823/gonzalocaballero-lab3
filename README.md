# Lab 3: Introduction to ActiveRecord
**Name:** (enter your name here) 

This assignment is INDIVIDUAL. You will follow your first steps towards creating models for an application, including associations. You will understand how models are created, how migrations work, and how model objects can be configured to be associated with others.

## First steps

The starter code contains a Rails project that has a few changes after its original creation. You may open the project by using RubyMine, or if you prefer, you may work with VSCode and/or the terminal, or even use a pro editor like Vim. If you work on the terminal, always remember to set the correct version of ruby and gemset using RVM:

```sh
rvm use 3@rails6 # this will work on the course's VM
```

If you take a look at the `db` directory, you will find there are two files:

* `schema.rb`: This file is automatically created by Rails when migrations are run. The file contains all DDL operations needed to initialize the database schema according to migrations.
* `seeds.rb`: It contains Ruby code that performs initialization in the database. You will see that a series of beers are created in the database.

Now, if you also take a look at `db/migrate`, you will see there is a single migration that creates a `beers` table in the database. This table corresponds, of course, to the `Beer` model. To see the current columns of the `beers` table (and attributes of the `Beer` model), one possibility is to take a look at `schema.rb` and have a look at the columns that are added to the `beers` table on initialization. 

The `Beer` model is created in the path `app/models/beer.rb`. You will see the initial implementation of the model is super minimalistic.

## Where fun begins

We will make a few improvements to the `Beer` model, and add another model. Then we will create associations among the models, and try them by using the RoR console (i.e., running `rails c` on the command line).

* [2 points] If you go back to `db/seeds.rb` you will see that beers contain brand as a string attribute. If you recall from your course about relational databases, this is not a proper way of keeping brand information. Brands are a data entity should be represented by a proper model. You are required to (1) create a migration that permits dropping the brand column from the `beers` table. For this, you may run the migrations generator on the command line (terminal) like:

```sh
rails g migration RemoveBrandFromBeer brand:string subbrand:string
```

The above will automatically create a migration that removes the `brand` column from the `beers` table, or equivalently, removes the `brand` attribute from the `Beer` model.

Do not forget to run the migration you just created:

```sh
rails db:migrate
```

Next (2) generate a Brand model:

```sh
rails g model Brand name:string
```

Finally (3), modify the `db/seeds.rb` file, so that brands are created before beers. Then, comment out the lines that create beers (you will enable these later).
* [1 point] Edit the `Beer` model (i.e., `app/models/beer.rb`). A beer should _belong to_ a brand. Add the implied association to the `Beer` model. On the other hand, a `Brand` can _have many_ `Beer`s. Edit the `Brand` model accordingly to implement the association needed. See the Authors and Books [code examples here](https://edgeguides.rubyonrails.org/association_basics.html) for some inspiration. In addition, you will need to add a foreign key column to the `Beer` model in order for the associations among models to work (i.e., **model associations must be always backed by proper foreign key references!**). For this, you need to create a migration:

```sh
rails g migration AddBrandForeignKeyToBeer
```

Then, edit the migration so that the `add_reference` method is invoked and the corresponding foreign key allowing a 1-N relationship among `brands` and `beers` is possible (i.e., a `Brand` can have many `Beer`s, whereas a `Beer` belongs to a `Brand`):

```ruby
add_reference :beers, :brand, foreign_key: true
```

See section 2 of [this guide](https://guides.rubyonrails.org/active_record_migrations.html#creating-a-migration) in order to see details about how foreign key references are created among tables.

Do not forget to apply the migration you just created!

```sh
rails db:migrate
```

* [1 point] Go back to the `db/seeds.rb` file. Now uncomment the lines that create beers. When creating each beer, do not pass the brand parameter as a string (remember you removed the `brand` column from the `Beer` model...). Take the reference to each beer created, and associate each `Beer` to a brand. The way to do this is as follows:

```ruby
brand1 = Brand.create(name: "Kunstmann")
beer1 = Beer.create(brand: brand1) # Tip: always use the name of the association in the Beer model as the name of the parameter.
```

Try out your `seeds.rb` file by recreating the database and then
seeding it:

```sh
rails db:drop # drop the current database
rails db:migrate # recreate the database and run migrations on it
rails db:seed # seed the database
```

* [1 point] Add a `User` model by using the Rails generator. Add attributes `first_name`, `last_name`, `email`. A user writes `Review`s, which contain an attribute called `text`, and a `rating`, of decimal type. In addition, a `Review` will hold a reference to the `Beer` being reviewed.
* [1 point] Add associations to models (and foreign key(s) to tables) required to ensure that a `User` can review many beers. Associations should permit accessing all reviews written by a `User`, and the `User` that has written a specific review. Add a `User` and a couple of associated `Review`s to your `db/seeds.rb` file and check out how it all works in the rails console (keep on reading to see the instructions below).

## About migrations

* Migrations that you create by using the rails generator can be modified by hand. You may do so in case you misstype column names, or types. If you need to modify a migration by hand, delete the database (run `db:drop`) (see below about database tasks), and start over recreating the database.

## Making sure it all works: The Rails Console

Ruby on Rails provides a console on which you may run ruby code that instances the models contained in your application, and allows you to try out the associations that are implemented. Just to give you an idea about what is possible, consider the following example:

```sh
rails c
> Beer.all # Will show all Beer models available
> Brand.first.beers # Will show all Beers of the first Brand found
> bb = Brand.create(...) # This will create a brand
> b = Beer.create(brand: bb) # Create a beer
> u = User.create(...)
> r = Review.new(user: u, beer: b, text: "I really liked this beer...", rating: 5)
> r.save
```

To quit the console, press Ctrl+D.

## Basic database tasks

Rails provides several database tasks that you may run on the command line whenever needed:

* `db:migrate` runs (single) migrations that have not run yet.
* `db:create` creates the database
* `db:drop` deletes the database
* `db:schema:load` creates tables and columns within the (existing) database following `schema.rb`
* `db:setup` does `db:create`, `db:schema:load`,  `db:seed`
* `db:reset` does `db:drop`, `db:setup`

Typically, you would use db:migrate after having made changes to the schema via new migration files (this makes sense only if there is already data in the database). `db:schema:load` is used when you setup a new instance of your app.

After you create a migration, do not forget to apply it to the database!

```sh
rails db:migrate
```

The following example will drop the current database and then recreate it, including initialization as specified in `db/seeds.rb`:

```sh
rails db:drop
rails db:setup
```






