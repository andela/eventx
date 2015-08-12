require 'rails_helper'

RSpec.describe Category, type: :model do
  DatabaseCleaner.strategy = :transaction
  # category_1 = Category.create({name: 'Alex', description: "Alex's special category for crappy things"})
  # category_2 = Category.create({name: 'Kay', description: "Kay's special category about parties where broken bottles were thrown"})

  it 'is invalid without a name' do
    category_1 = Category.create({name: 'Alex', description: "Alex's special category for crappy things"})
    category_2 = Category.create({description: "Alex's special category for crappy things"})

    expect(category_1).to be_valid
    expect(category_2).to be_valid
  end
end
