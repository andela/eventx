require "rails_helper"

RSpec.describe RecurringEvent, type: :model do
  subject { build(:recurring_event) }

  it { is_expected.to be_valid }
  it { should respond_to :day }
  it { is_expected.to respond_to :week }
  it { should belong_to :event }
end
