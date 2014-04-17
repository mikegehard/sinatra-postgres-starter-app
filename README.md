# Sinatra template application

This application can be used as a starting point for a [Postgres](http://www.postgresql.org/)
database backed, via [Sequel](http://sequel.jeremyevans.net/), application that uses
[Sinatra](http://www.sinatrarb.com/). It can be deployed to [Heroku](https://www.heroku.com/).

There are a few things you need to change for your application:

1. Change `scrips/create_databases.sql` to create both your development and test databases.
1. Copy the `.env.example` file to `.env`.
1. Change the `.env` file to include your database connection strings for both your development
and test databases. This file is ignored by git (see .gitignore) to protect your secrets
from the outside world.
1. Add your migrations to the `migrations` folder. Once you have one migration there, you can
delete the `.gitsave` file. You should also uncomment the line in `spec/spec_helper.rb` so that
your databases will be cleaned up between test runs.

## Development
1. `bundle install`
1. Create a database by running `psql -d postgres -f scripts/create_databases.sql`
1. Run the migrations in the development database using `rake db:migrate`. If you would
like to migrate to a specific version you can do so using this rake task. Run `rake -T` for
details.
1. Run the migrations in the testing database using `RACK_ENV=test rake db:migrate`. 
1. `rerun rackup`
    * running rerun will reload app when file changes are detected
1. Run tests using `rspec`. The tests will clean up the database before each test run.

## Migrations on Heroku
To run the migrations on heroku, run `heroku run 'rake db:migrate'`. If you
do not have a Heroku configuration variable named DATABASE_URL, then you will need to create one.
