require 'sqlite3'
require 'byebug'

# https://tomafro.net/2010/01/tip-relative-paths-with-file-expand-path
ROOT_FOLDER = File.join(File.dirname(__FILE__), '..')
SQL_FILE = File.join(ROOT_FOLDER, 'migrations', 'tables.sql')
SEEDS_FILE = File.join(ROOT_FOLDER, 'seeds', 'seeds.sql')
DB_FILE = File.join(ROOT_FOLDER, 'app.db')

class DBConnection
  def self.open(db_file_name)
    @db = SQLite3::Database.new(db_file_name)
    @db.results_as_hash = true
    @db.type_translation = true
    @db
  end

  def self.reset
    commands = [
      "rm '#{DB_FILE}'",
      "cat '#{SQL_FILE}' | sqlite3 '#{DB_FILE}'",
      "cat '#{SEEDS_FILE}' | sqlite3 '#{DB_FILE}'"
    ]

    commands.each { |command| `#{command}` }

  end

  def self.instance
    DBConnection.open(DB_FILE)

    @db
  end

  def self.execute(*args)
    puts args[0]
    instance.execute(*args)
  end

  def self.execute2(*args)

    instance.execute2(*args)
  end

  def self.last_insert_row_id
    instance.last_insert_row_id
  end

  private

  def initialize(db_file_name)
  end
end
