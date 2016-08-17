require 'pg'
require 'byebug'
require 'yaml'

# https://tomafro.net/2010/01/tip-relative-paths-with-file-expand-path
ROOT_FOLDER = File.dirname(__FILE__)
DB_NAME = YAML.load_file(File.join(ROOT_FOLDER, '..', 'config.yml'))['dbname']
class DBConnection
  def self.open(config = {})
    uri = URI.parse(ENV['DATABASE_URL'])
    @db = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)

    @db
  end

  def self.instance
    DBConnection.open

    @db
  end

  def self.execute(*args)
    puts args[0]
    instance.exec_params(*args).to_a
  end

  def self.col_names(table_name)
    self.execute(<<-SQL, [table_name]).map { |col| col["column_name"] }
      SELECT column_name
      FROM information_schema.columns
      WHERE table_name=$1;
    SQL
  end

  private

  def initialize(db_file_name)
  end
end

puts DBConnection.col_names("desserts")
