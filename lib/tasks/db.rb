require 'rake'
require 'dotenv/tasks'

namespace :db do
  desc 'Run migrations up to specified version or to latest.'
  task :migrate, [:version] => [:dotenv] do |_, args|
    require 'sequel'
    Sequel.extension :migration

    environment = ENV['RACK_ENV'] || 'development'
    version = args[:version]
    migrations_directory = 'migrations'
    connection_string = ENV['DATABASE_URL'] || ENV["DATABASE_URL_#{environment.upcase}"]

    raise "Missing Connection string" if connection_string.nil?

    db = Sequel.connect(connection_string)
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