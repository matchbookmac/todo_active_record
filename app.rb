require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/list')
require('./lib/task')
require('pg')

get('/') do
  @tasks = Task.all()
  erb(:index)
end

post('/tasks/new') do
  @task = Task.create(description: params['description'])
  @tasks = Task.all()  
  erb(:index)
end
