require 'rails_helper'
#homeに飛べるかどうかの確認
RSpec.describe 'Access to static_pages', type: :request do
  context 'static_pages#home' do
    before { get root_path }
    it 'responds successfully' do
      expect(response).to have_http_status 200
    end
    
    end
end

#sign up （新しくユーザーを登録）のページに飛べるか
RSpec.describe 'access to sign up page', type: :request do 
  describe 'GET #new' do
    it 'responds successfully' do
      get signup_path
      expect(response).to have_http_status 200
    end
  end
end

#ユーザー登録時に有効なリクエストと無効なリクエストを送ったときのテスト

describe 'POST #create' do
    #有効なユーザーの検証
    context 'valid request' do
      #ユーザーが追加される
      it 'adds a user' do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      #ユーザーが追加されたときの検証
      context 'adds a user' do
        before { post signup_path, params: { user: attributes_for(:user) } }
        subject { response }
        it { is_expected.to redirect_to user_path(User.last) } #showページにリダイレクトされる
        it { is_expected.to have_http_status 302 } #リダイレクト成功
      end
    end

    #無効なリクエスト
    context 'invalid request' do
      #無効なデータを作成
      let(:user_params) do
        attributes_for(:user, name: '',
                              email: 'user@invalid',
                              password: '',
                              password_confirmation: '')
      end
      #ユーザーが追加されない
      it 'does not add a user' do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
        end
    end
end

RSpec.describe "UsersLoginApi", type: :request do
  

  it "sessions/newにアクセスできること" do
    #ログインページにアクセスします
    get login_path
    expect(response).to have_http_status(:success)
  end

  describe "<sessions#new>" do
    context "ログインに失敗した時" do
      it "フラッシュメッセージの残留をキャッチすること" do
        get login_path
        expect(response).to have_http_status(:success)

        #「email:""」と「password:""」の値を持ってlogin_pathにアクセスします
        # → バリデーションに引っかかりログインできません
        post login_path, params: { session: { email: "", password: "" }}
        expect(response).to have_http_status(:success)

        #flash[:danger]が表示されているかチェックします
        expect(flash[:danger]).to be_truthy

        #Rails Tutorialだと、minitest記述でbe_emptyとありますが、
        #be_emptyで「flash[:danger]のテストを行うとエラーになります。
        #get root_pathに移動前：expect(flash[:danger]).to_not be_empty → GREEN
        #get root_pathに移動前：expect(flash[:danger]).to be_truthy → RED
        #エラーを見ると返り値が"true"だったため、be_truthyとbe_falseyにしています。

        #root_path（別ページ）に移動してflash[:danger]が表示されていないかチェックします
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end
  end
end




