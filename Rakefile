require 'dotenv/tasks'

namespace :db do
  desc "Run migrations up to specified version or to latest."
  task :migrate, [:version] => [:dotenv]  do |_, args|
    require "sequel"
    Sequel.extension :migration
    environment = ENV['RACK_ENV'] || "development"
    db = Sequel.connect(ENV.fetch("DATABASE_URL_#{environment.upcase}"))
    version = args[:version]

    if args[:version].nil?
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "migrations")
    else
      puts "Migrating to version #{version}"
      Sequel::Migrator.run(db, "migrations", target: version.to_i)
    end
  end
end