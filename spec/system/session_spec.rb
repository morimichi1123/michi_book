require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    visit login_path
  end
  

  #無効な値を入力する
  describe 'enter an invalid values' do
    before do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
    end
    subject { page }
    #フラッシュメッセージが出る
    it 'gets an flash messages' do
      is_expected.to have_selector('.alert-danger', text: 'Invalid email/password combination')
      is_expected.to have_current_path login_path
    end
    #違うページにアクセスしたとき
    context 'access to other page' do
      before { visit root_path }
      #フラッシュメッセージが消える
      it 'is flash disappear' do
        is_expected.to_not have_selector('.alert-danger', text: 'Invalid email/password combination')
      end
    end
  end
end