require('spec_helper')

describe(Task) do

  describe("#description") do
    it("lets you give it a description") do
      test_task = Task.new({:description => "scrub the zebra", :due_date => "2015-01-23"})
      expect(test_task.description()).to(eq("scrub the zebra"))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same task if it has the same description and due date") do
      test_task1 = Task.new({:description => "scrub the zebra", :due_date => "2015-01-22 00:00:00"})
      test_task2 = Task.new({:description => "scrub the zebra", :due_date => "2015-01-22 00:00:00"})
      expect(test_task1).to(eq(test_task2))
    end
  end

  describe('#save') do
    it("saves data to database") do
      test_task = Task.new({:description => "scrub the zebra", :due_date => "2015-01-22 00:00:00"})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end
end
