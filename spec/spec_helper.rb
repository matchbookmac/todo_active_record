ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('pry')
require('./lib/list')
require('./lib/task')
require('sinatra')
require('sinatra/reloader')
require('capybara/rspec')
