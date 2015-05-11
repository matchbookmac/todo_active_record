require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/list')
require('./lib/task')
require('pg')

get('/') do
  task = Task.create({description: "hello there", done: false})
  task2 = Task.create({description: "hiya back", done: false})
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
