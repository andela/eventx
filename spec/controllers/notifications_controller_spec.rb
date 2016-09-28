require 'rails_helper'
require "support/booking_helper"
include BookingHelper

RSpec.describe NotificationsController, type: :controller do
  describe 'before actions' do
    it { should use_before_action :find_notification }
  end

  describe '#create' do
    before(:each) do
      sign_in_omniauth
    end

    it 'succeeds with valid parameters' do
      expect {
        post :create,
                notification_subscription:
                  attributes_for(:notification_subscription)
              }.to change(NotificationSubscription, :count).by 1
      expect(assigns(:subscription)).not_to be_nil
      expect(flash[:notice]).to be_present
    end

    it 'fails without a valid user id' do
      expect {
        post :create,
          notification_subscription:
            attributes_for(:notification_subscription, user_id: nil)
      }.not_to change(NotificationSubscription, :count)
    end

    it 'fails without a valid category id' do
      expect {
        post :create,
          notification_subscription:
            attributes_for(:notification_subscription, category_id: nil)
      }.not_to change(NotificationSubscription, :count)
    end
  end

  describe '#destroy' do
    before do
      request.env["HTTP_REFERER"] = '/users/settings'
    end

    it 'succeeds with valid parameters' do
      notification = create(:notification_subscription)
      expect {
        delete :destroy, id: notification
        }.to change(NotificationSubscription, :count).by(-1)
      expect(flash[:notice]).to be_present
    end
  end
end
