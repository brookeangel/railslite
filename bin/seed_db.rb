require 'yaml'

dbconfig = YAML.load_file(File.dirname(__FILE__) + "/../orm_lite/config.yml")
dbname = dbconfig["dbname"]

dbseeds = File.dirname(__FILE__) + "/../orm_lite/seeds/seeds.sql"

system("cat #{dbseeds} | psql #{dbname}")
