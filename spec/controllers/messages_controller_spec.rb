require 'rails_helper'
require 'support/booking_helper'
include BookingHelper

RSpec.describe MessagesController, type: :controller do
  before(:each) do
    sign_in_omniauth
    request.env['HTTP_REFERER'] = 'dashboard/messages'
  end
  describe 'before action' do
    it { should use_before_action :find_message }
  end

  describe '#index' do
    before do
      get :index
    end
    it 'sets the instance variable' do
      expect(assigns(:messages)).not_to be_nil
    end
    it { should render_with_layout 'admin' }
    it { should render_template 'index' }
  end

  describe '#show' do
    before do
      @my_message = create(:message)
      get :show, id: @my_message.id
    end
    it 'has a valid instance variable' do
      expect(assigns(:message)).not_to be_nil
    end
    it { should render_with_layout 'admin' }
    it { should render_template 'show' }
  end

  describe '#destroy' do
    before do
      @message = create(:message)
    end
    it 'successfully deletes a message' do
      expect {
        delete :destroy, id: @message.id
      }.to change(Message, :count).by -1
      expect(flash[:notice]).to be_present
    end
  end
end
