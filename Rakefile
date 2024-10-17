require "active_record"

namespace :db do

  config = {
    adapter:  "postgresql",
    url: 'postgresql://postgres@postgres:5432'
  }

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(config)
    ActiveRecord::MigrationContext.new("db/migrate/").migrate
    puts "Database migrated."
  end

  desc "Delete all tables"
  task :clear do
    ActiveRecord::Base.establish_connection(config)
    tables = ActiveRecord::Base.connection.tables
    tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
      puts "Dropped table: #{table}"
    end

    puts "All tables dropped."
  end
end