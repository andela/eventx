require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'Create a user' do
    user = User.create({id: 2, first_name: 'OreO' })

    assert_equal user.id, 2
  end
end
