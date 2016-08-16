require 'yaml'

dbconfig = YAML.load_file(File.dirname(__FILE__) + "/../orm_lite/config.yml")
dbname = dbconfig["dbname"]

dbsetup = File.dirname(__FILE__) + "/../orm_lite/migrations/tables.sql"

system("cat #{dbsetup} | psql #{dbname}")
