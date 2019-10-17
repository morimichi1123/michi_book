require 'rails_helper'

RSpec.feature "About page transition", type: :feature do

  before do
      @user = FactoryBot.create(:user)
  end

  feature 'home page' do 
    before do
      visit root_path
    end

    it 'homeにWelcome to the Naokis Book Store文字が現れる' do
      expect(page).to have_content "Welcome to the Naoki's Book Store"
    end

    it 'title have Book APP' do
      expect(page).to have_title "Book APP"
    end
  end

  feature 'signup page' do 
    before do
      visit signup_path
    end

    it 'Sign up文字が現れる' do
      expect(page).to have_content "Sign up"
    end

    it 'title have Book APP' do
      expect(page).to have_title "Sign up | Book APP"
    end

    it 'ボタンのCreate my accountがある' do
      expect(page).to have_button "Create my account"
    end
    feature 'new createした時の挙動' do
      before do
        fill_in 'Name',         with: 'hoge'
        fill_in 'Email',        with: 'hoge@hoge.com'
        fill_in 'Password',     with: 'hogehoge'
        fill_in 'Confirmation', with: 'hogehoge'
        click_button 'Create my account'
      end

      it 'root_pathに遷移する' do
        expect(current_path).to eq index_path
      end

      it "成功するとメッセージがでる=>'Welcome to the Naoki's Book Store!'" do
        expect(page).to have_content "Welcome to the Naoki's Book Store!"
      end
    end
    feature 'new createに失敗した時の挙動テスト' do
      before do
        fill_in 'Name',         with: 'hoge'
        fill_in 'Email',        with: 'test@hoge.com'
        fill_in 'Password',     with: 'hogehoge'
        fill_in 'Confirmation', with: 'fugafuga'
        click_button 'Create my account'
      end

      it 'sign_pathに遷移する' do
        expect(current_path).to eq signup_path
      end
      

      it "passwordが違うとエラーメッセージがでる" do
        expect(page).to have_content "The form contains 1 error."
        expect(page).to have_content  'doesn\'t match'
      end
    end



  end

  

end
