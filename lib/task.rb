class Task
  attr_reader(:description, :due_date)


  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @due_date = attributes.fetch(:due_date)
  end

  define_method(:description) do
    @description
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      due_date = task.fetch("due_date")
      tasks.push(Task.new({:description => description, :due_date => due_date}))
    end
    tasks
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description, due_date) VALUES ('#{@description}', '#{@due_date}');")
  end

  define_method(:==) do |task|
    self.description() == task.description() && self.due_date() == task.due_date()
  end

end
