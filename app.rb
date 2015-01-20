require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('pg')

DB = PG.connect({:dbname => 'to_do_db'})

get("/") do
  @tasks = Task.all()
  erb(:form)
end

post("/tasks") do
  description = params.fetch("description")
  task = Task.new(description)
  task.save()
  erb(:success)
end
