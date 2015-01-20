require('spec_helper')

describe(Task) do
  before() do
    Task.clear()
  end

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

end
