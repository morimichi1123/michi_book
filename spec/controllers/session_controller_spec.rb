require 'rails_helper'


RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success using "get"' do
      get :new
      expect(response).to have_http_status(:success)
    end
    feature 'login_path' do
      before do
        visit login_path
      end
    it "returns http success using path" do
      expect(page).to have_http_status(:success)
    end
  end
  end
end