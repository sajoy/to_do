require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')

DB = PG.connect({:dbname => 'to_do_db'})

get("/") do
  @lists = List.all()
  erb(:index)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  @lists = List.all()
  erb(:index)
end

get("/lists/:id") do
  @id = params.fetch("id").to_i
  @list = List.find(@id)
  @tasks = @list.tasks()
  erb(:list)
end

post("/add_task") do
  description = params.fetch("description")
  due_date = params.fetch("due_date")
  @id = params.fetch("list_id").to_i
  task = Task.new({:description => description, :due_date => due_date, :list_id => @id})
  task.save()
  @list = List.find(@id)
  @tasks = @list.tasks()
  erb(:list)
end
