class List
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end

  define_method(:tasks) do
    task_array = []
    tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id};")
    tasks.each() do |task|
      symbol_key = task.each_with_object({}){|(k,v), h| h[k.to_sym] = v}
        # http://stackoverflow.com/questions/800122/best-way-to-convert-strings-to-symbols-in-hash
        # changes string keys to symbol keys
      task_array.push(Task.new(symbol_key))
    end
    task_array
  end

  define_method(:sort_tasks) do
    sorted =[]
    unsorted = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id} ORDER BY due_date ASC;")
    unsorted.each() do |task|
      symbol_key = task.each_with_object({}){|(k,v), h| h[k.to_sym] = v}
      sorted.push(Task.new(symbol_key))
    end
    sorted
  end

  define_singleton_method(:find) do |id|
    found_list = nil
    List.all().each() do |list|
      if list.id().==(id)
        found_list = list
      end
    end
    found_list
  end

end
