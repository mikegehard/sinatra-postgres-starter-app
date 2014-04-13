ENV['RACK_ENV'] = 'test'

require_relative '../boot'

require 'lib/tasks/db'

RSpec.configure do |config|
  config.order = 'random'

  config.before(:each) do
    migration_task = Rake::Task['db:migrate']
    migration_task.invoke(0)
    migration_task.reenable
    migration_task.invoke
  end
end