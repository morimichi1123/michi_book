#ユーザー登録時のエラーやフラッシュメッセージ
require 'rails_helper'

RSpec.describe 'users', type: :system do
  describe 'user create a new account' do
    #有効な値が入力されたとき
    context 'enter an valid values' do
      before do
        visit signup_path
        fill_in 'Name', with: 'testuser'
        fill_in 'Email', with: 'testuser@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirmation', with: 'password'
        click_button 'Create my account'
      end
      #フラッシュメッセージが出る
      it 'gets an flash message' do
        expect(page).to have_selector('.alert-success', text: "Welcome to the Naoki's Book Store!")
      end
    end
    #無効な値が入力されたとき
    context 'enter an invalid values' do
      before do
        visit signup_path
        fill_in 'Name', with: ''
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        fill_in 'Confirmation', with: ''
        click_button 'Create my account'
      end
      subject { page }
      #エラーの検証
      it 'gets an errors' do
        is_expected.to have_selector('#error_explanation')
        is_expected.to have_selector('.alert-danger', text: 'The form contains 6 errors.')
        is_expected.to have_content("Password can't be blank", count: 2)
      end
      #今いるページのURLの検証
      it 'render to /signup url' do
        is_expected.to have_current_path '/signup'
      end
    end
  end
end