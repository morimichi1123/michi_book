require 'rails_helper'

RSpec.describe Book, type: :model do
    #FactoryBotで本の情報を@bookに登録
    before do
        @book = FactoryBot.build(:book)
    end

    describe 'validate of book information' do
        it { is_expected.to validate_presence_of :author }
        it { is_expected.to validate_length_of(:author).is_at_most(50) }
        it { is_expected.to validate_presence_of :title }
        it { is_expected.to validate_length_of(:title).is_at_most(50) }
        it { is_expected.to validate_presence_of :publisher }
        it { is_expected.to validate_length_of(:publisher).is_at_most(50) }
        it { is_expected.to validate_presence_of :genre }
        it { is_expected.to validate_length_of(:genre).is_at_most(50) }
        
    end




end
