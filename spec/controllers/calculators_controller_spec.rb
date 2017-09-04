require 'rails_helper'

RSpec.describe CalculatorsController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #calculate' do
    context 'when expression is valid' do
      before(:each) do
        xhr :get, :calculate, :q => '222+3'
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the calculate template' do
        expect(response).to render_template('calculate')
      end
    end

    context 'when expression is invalid' do
      before(:each) do
        xhr :get, :calculate, :q => '222+3*(8+3)'
      end

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the calculate template' do
        expect(response).to render_template('calculate')
      end
    end
  end
end
