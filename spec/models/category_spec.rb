require "rails_helper"

RSpec.describe Category, type: :model do
  before { @category = FactoryGirl.build :category }

  subject { @category }

  it { should respond_to :name }
  it { should respond_to :description }

  it { should be_valid }

  it { should validate_presence_of :name }
end
