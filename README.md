# MiniFrame

A simple framework and ORM built on Rack and modeled after Rails.

[See it live!](https://miniframe.herokuapp.com/)

## Features

* ORM
* Router
* MVC Architecture

## Test Out MiniFrame

0. Clone this repo to your local machine
0. Run `$ bundle install`
0. Create your PSQL database and set the db name in 'orm_lite/config.yml'
0. Run `ruby bin/setup_db.rb` and `ruby bin/seed_db.rb` to setup and seed the database
0. Start the server by running `$ bundle exec rackup -p 3000 config.ru`
0. Check out the live app at `localhost:3000`!
