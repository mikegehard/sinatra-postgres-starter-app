$LOAD_PATH.unshift('./')

require 'sequel'
require 'application'
require 'dotenv'

Dotenv.load

connection_string = ENV["DATABASE_URL"] || ENV["DATABASE_URL_TEST"]

require 'lib/user_repository'

UserRepository.attach_db(Sequel.connect(ENV['DATABASE_URL']))

DB = Sequel.connect(connection_string)