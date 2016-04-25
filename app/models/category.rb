class Category < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name, notice: "Category exists" 
  has_many :events
end
