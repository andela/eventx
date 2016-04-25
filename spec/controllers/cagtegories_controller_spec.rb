require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  before(:each) do
    @category = attributes_for(:category)
  end

  describe '#create' do
    context 'when a valid category is given' do 
      it 'creates a new category' do
        expect {
                post :create, category: @category, format: 'js'
               }.to change(Category, :count).by(1)
      end 

      it 'returns a successful HTTP response' do 
        expect(response.status).to eq 200 
      end 
    end 
      context 'when a category already exists' do 
        it 'should not create it' do 
          create(:category)
          expect {
                 post :create, category: @category, format: 'js'
                }.to_not change(Category, :count)
        end
      end 
  end 
end
