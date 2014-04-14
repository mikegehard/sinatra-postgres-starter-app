ENV['RACK_ENV'] = 'test'

require_relative '../boot'
require 'lib/tasks/db'
require 'lib/user_repository'
require 'rspec'

DB = Sequel.connect(ENV['DATABASE_URL_TEST'])

UserRepository.attach_db(DB)

RSpec.configure do |config|
  config.order = 'random'

  config.before(:each) do
    migration_task = Rake::Task['db:migrate']
    migration_task.invoke(0)
    migration_task.reenable
    migration_task.invoke
  end
end