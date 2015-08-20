require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  test 'should get new' do
    User.create({id: 2, first_name: 'OreO' })
    session[:user_id] = 2
    get :new
    assert_response :success
  end
end
