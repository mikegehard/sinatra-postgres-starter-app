require 'rake'
require 'dotenv/tasks'

namespace :db do
  desc 'Run migrations up to specified version or to latest.'
  task :migrate, [:version] => [:dotenv]  do |_, args|
    require 'sequel'
    Sequel.extension :migration

    environment = ENV['RACK_ENV'] || 'development'
    version = args[:version]
    migrations_directory = 'migrations'

    db = Sequel.connect(ENV.fetch("DATABASE_URL_#{environment.upcase}"))
    message = if args[:version].nil?
      Sequel::Migrator.run(db, migrations_directory)
      'Migrated to latest'
    else
      Sequel::Migrator.run(db, migrations_directory, target: version.to_i)
      "Migrated to version #{version}"
    end

    puts message if environment != 'test'
  end
end