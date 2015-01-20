require('spec_helper')

describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      list1 = List.new({:name => "Epicodus stuff", :id => nil})
      list2 = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list1).to(eq(list2))
    end
  end

  describe("#tasks") do
    it("returns an array of all the tasks in a list") do
      food = List.new({:name => "groceries", :id => nil})
      food.save()
      food1 = Task.new({:description => "apples", :due_date => "2015-01-24 00:00:00", :list_id => food.id()})
      food1.save()
      food2 = Task.new({:description => "oranges", :due_date => "2015-01-24 00:00:00", :list_id => food.id()})
      food2.save()
      expect(food.tasks()).to(eq([food1, food2]))
    end
  end


end
