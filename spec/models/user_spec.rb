require 'rails_helper'

RSpec.describe User, type: :model do
  #FactoryBotでユーザー情報を@userに登録
  before do
    @user = FactoryBot.build(:user)
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most(300) }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  
  

  context "when email format is invalid" do
    it "emailのvalidateが正しく機能しているか" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
      end
    end
  end

  context "when email addresses should be unique" do
    it "一意性が正しく機能しているか" do
      #@userを複製してduplicate_userに格納
      duplicate_user = @user.dup
      #@userのemailを大文字でduplcate_userのemailに格納
      duplicate_user.email = @user.email.upcase
      @user.save!
      expect(duplicate_user).to be_invalid
    end
  end

  it "emailを小文字に変換後の値と大文字を混ぜて登録されたアドレスが同じか" do
    #わかりやすくベタ書き
    
    @user.email = "Foo@ExAMPle.CoM"
    @user.save!

    #全て小文字のemailと等しいかのテスト
    expect(@user.reload.email).to eq "foo@example.com"
  end

  it "passwordが空白になっていないか" do
    #" "* 6だけだと何をテストしているのか曖昧なため、"a"*6の場合のテストも追加
    #"a"が6文字のパスワードのテスト
    @user.password = @user.password_confirmation = "a" * 6
    expect(@user).to be_valid

    #" "が６文字のパスワードのテスト
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).to_not be_valid
  end

  #パスワードのテスト
  describe "password length" do
    #パスワードが6桁の時と５桁の時のテストを行うことで、どの位置からバリデーションが用意されているのか可視化している
    context "パスワードが６桁の時" do
      it "正しいかつ一致している" do
        @user = FactoryBot.build(:user, password: "a" * 6, password_confirmation: "a" * 6)
        expect(@user).to be_valid
      end
    end

    context "パスワードが５桁の時" do
      it "正しくない" do
        @user = FactoryBot.build(:user, password: "a" * 5, password_confirmation: "a" * 5)
        expect(@user).to be_invalid
      end
    end
  end


  context "パスワードが一致しない時" do
      it "一致していない" do
        user = FactoryBot.build(:user, password: "a" * 6, password_confirmation: "b" * 6)
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
  end

  


end
