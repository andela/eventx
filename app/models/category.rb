class Category < ActiveRecord::Base
  has_many :events
end
