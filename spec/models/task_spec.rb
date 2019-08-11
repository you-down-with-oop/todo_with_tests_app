require "rails_helper"

RSpec.describe Task, type: :model do
  describe "#toggle_complete!" do
    it "should switch complete to false if it began as true" do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it "should switch complete to true if it began as false" do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe "#toggle_favorite!" do
    it "should switch favorite to false if it began as true" do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it "should switch favorite to true if it began as false" do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe "#overdue?" do
    it "should return true if an incomplete task's deadline is earlier than now" do
      task = Task.create(deadline: 1.day.ago, complete: false)
      result = task.overdue?
      expect(result).to eq(true)
    end

    it "should return false if an incomplete task's  deadline is later than now" do
      task = Task.create(deadline: 1.day.from_now, complete: false)
      result = task.overdue?
      expect(result).to eq(false)
    end

    it "should return false for a complete task regardless of the deadline" do
      task = Task.create(deadline: 1.day.ago, complete: true)
      result = task.overdue?
      expect(result).to eq(false)
    end
  end

  describe "#increment_priority!" do
    it "should increase priority by 1" do
      task = Task.create(priority: 4)
      task.increment_priority!
      expect(task.priority).to eq(5)
    end

    it "should not increase priority past 10" do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe "#decrement_priority!" do
    it "should decrement priority by 1" do
      task = Task.create(priority: 5)
      task.decrement_priority!
      expect(task.priority).to eq(4)
    end

    it "should not decrement priority beyond 1" do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe "#snooze_hour!" do
    it "should increase deadline by 1 hour" do
      deadline = 3.days.from_now
      task = Task.create(deadline: deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
    end
  end
end
