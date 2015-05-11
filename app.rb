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
  @lists = List.all()
  erb(:index)
end

get('/reset') do
  Task.all().each do |task|
    task.destroy()
  end
  List.all().each do |list|
    list.destroy()
  end
  redirect to('/')
end

post('/tasks/new') do
  list = List.find(params['list'])
  @task = list.tasks.create({description: params['description'], done: false})
  @tasks = Task.all()
  @lists = List.all()
  redirect to("/lists/#{list.id}")
end

post('/lists/new') do
  list = List.create(name: params['name'])
  @tasks = Task.all()
  @lists = List.all()
  redirect to('/')
end

# Edit task description
get('/lists/:list_id/tasks/:task_id/edit') do
  @list = List.find(params['list_id'].to_i())
  @task = Task.find(params['task_id'].to_i())
  erb(:task_edit)
end

patch('/lists/:list_id/tasks/:task_id/edit') do
  @list = List.find(params['list_id'].to_i())
  @task = Task.find(params['task_id'].to_i())
  @task.update(description: params['description'])
  @tasks = Task.all
  redirect to("/lists/#{@list.id}")
end

# Show specific list
get('/lists/:id') do
  @list = List.find(params['id'])
  @lists = List.all()
  erb(:list)
end

# Mark task as done
patch('/lists/:id') do
  task_ids = params['task_id']
  task_ids.each do |task_id|
    task = Task.find(task_id)
    task.update({done: true})
  end
  @list = List.find(params['id'])
  @lists = List.all()
  erb(:list)
end
