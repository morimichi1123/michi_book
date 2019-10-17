require 'rails_helper'

RSpec.feature 'Admin User', type: :feature do
    feature 'Not Admin User' do
        before do
            @user = FactoryBot.create(:user, admin:false)
        end


        feature "ログインした後の挙動テスト" do

            before do
              visit login_path
              fill_in "Email", with: @user.email
              fill_in "Password", with: @user.password
              click_button "Log in"
            end
        
            it 'ログイン成功した場合' do
                expect(current_path).to eq root_path
                expect(page).to_not have_css("li", text: "Log in")
                expect(page).to have_css("li", text: "Log out")
                expect(page).to have_content "Book List"
                expect(page).to have_content "Add New Book"
            end
        end
        
        feature 'adminユーザーじゃないものは編集ができないか確認テスト' do
            before do
              FactoryBot.create_list(:book, 20)
              visit login_path
              fill_in "Email", with: @user.email
              fill_in "Password", with: @user.password
              click_button "Log in"
              visit edit_book_path(1)
            end

            it 'edit_pageに飛べない' do
                expect(current_path).to eq root_path
            end

        end
    end

    feature ' Admin User' do
        before do
            @user = FactoryBot.create(:user, admin:true)
        end


        feature "ログインした後の挙動テスト" do

            before do
              visit login_path
              fill_in "Email", with: @user.email
              fill_in "Password", with: @user.password
              click_button "Log in"
            end
        
            it 'ログイン成功した場合' do
                expect(current_path).to eq root_path
                expect(page).to_not have_css("li", text: "Log in")
                expect(page).to have_css("li", text: "Log out")
                expect(page).to have_content "Book List"
                expect(page).to have_content "Add New Book"
            end
        end
        
        feature 'adminユーザーはeditページに飛べるかを確認テスト' do
            before do
              FactoryBot.create_list(:book, 20)
              visit login_path
              fill_in "Email", with: @user.email
              fill_in "Password", with: @user.password
              click_button "Log in"
              visit edit_book_path(2)
            end

            it 'edit_pageに遷移できる' do
                expect(current_path).to eq edit_book_path(2)
                expect(page).to have_button 'Update Book Information'
            end

        end
    end

end