require "rails_helper"

RSpec.describe Task, type: :model do
  it "should have a valid factory" do
    task = build(:task)
    expect(task).to be_valid
  end

  describe "task associations" do
    it { is_expected.to belong_to :event }
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :assigner }
  end

  describe "task validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:assigner) }
  end

  describe "#my_tasks" do
    it "shows only the current ßuser's tasks" do
      user1 = create(:regular_user)
      user2 = create(:regular_user)
      assigner = create(:user)
      event = create(:regular_event)
      create(:task, user: user1, assigner: assigner, event: event)
      create(
        :task, name: "My task",
               user: user1,
               assigner: assigner,
               event: event
      )
      create(:task, user: user2, assigner: assigner, event: event)

      expect(user1.tasks.find_by(name: "My task")).to \
        eq(Task.find_by(name: "My task"))
      expect(user1.tasks).to_not include(user2.tasks)
    end
  end
end
