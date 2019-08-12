require "rails_helper"

RSpec.describe List, type: :model do
  describe "#complete_all_tasks!" do
    it "should change all tasks from the list to complete" do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe "#snooze_all_tasks!" do
    it "should increase deadline of each task by 1 hour" do
      my_deadline = Time.now
      list = List.create(name: "Chores")
      Task.create(deadline: my_deadline, list_id: list.id)
      Task.create(deadline: my_deadline, list_id: list.id)
      Task.create(deadline: my_deadline, list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(my_deadline + 1.hour)
      end
    end
  end

  describe "#total_duration" do
    it "should sum the durations of all tasks in the list" do
      list = List.create
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 150, list_id: list.id)
      expect(list.total_duration).to eq(200)
    end
  end

  describe "#incomplete_tasks" do
    it "should return an array of all incomplete tasks" do
      list = List.create
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      expect(list.incomplete_tasks.length).to eq(3)
    end
  end

  describe "#favorite_tasks" do
    it "should return an array of all favorite tasks" do
      list = List.create
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      expect(list.favorite_tasks.length).to eq(1)
    end
  end
end
