$LOAD_PATH.unshift('./')

require 'sequel'
require 'application'
require 'dotenv'

Dotenv.load

environment = ENV["RACK_ENV"] || "development"

connection_string = ENV["DATABASE_URL"] || ENV["DATABASE_URL_#{environment.upcase}"]

DB = Sequel.connect(connection_string)