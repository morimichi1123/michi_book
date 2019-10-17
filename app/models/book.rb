class Book < ApplicationRecord

    #validatesはメソッド
    validates :title, presence: true, length:{maximum:50}
    validates :author, presence: true, length:{maximum:50}
    validates :publisher, presence: true, length:{maximum:50}
    validates :genre, presence: true, length:{maximum:50}

    def self.search(search) #ここでのself.はBooks. を意味する
      if search
        where(['title LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
      else
        all #全て表示。Book. は省略
      end
    end
end
