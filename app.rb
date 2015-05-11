require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/list')
require('./lib/task')
require('pg')
require('pry')

get('/') do
  @tasks = Task.all()
  erb(:index)
end

post('/tasks/new') do
  @task = Task.create(description: params['description'])
  @tasks = Task.all()
  erb(:index)
end

get('/tasks/:id/edit') do
  @task = Task.find(params['id'].to_i())
  erb(:task_edit)
end

patch('/tasks/:id') do
  @task = Task.find(params['id'].to_i())
  @task.update(description: params['description'])
  @tasks = Task.all
  erb(:index)
end
