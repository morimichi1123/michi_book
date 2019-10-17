## 判定テストの準備
### Dockerについて
#### docker imageの作成
```
docker build -t rails/testsample .
```
#### docker コンテナの作成

```
docker run  -d --privileged -p 3005:3005 --name naoki_test rails/testsample /sbin/init
```
###  Mysqlについて
#### mysqlの設定
https://enomotodev.hatenablog.com/entry/2016/09/01/225200

##### MySQL の初期パスワード確認
```
cat /var/log/mysqld.log | grep password
```
##### MySQL のセキュリティ設定
```
mysql_secure_installation
```
### Gitについて
#### Git周りの設定
https://qiita.com/shizuma/items/2b2f873a0034839e47ce
##### SSH Keyの設定
```
ssh-keygen -t rsa -C "kishimoto.naoki@lmi.ne.jp"
```
##### 公開鍵の登録
###### 下記の鍵をGithubに登録
```
cat ~/.ssh/id_rsa.pub
```
##### 登録できたか確認
```
 ssh -T git@github.com
```

#### Gitの設定ファイルの種類と場所（system, global, local）
| 種類        | 対象範囲      | 場所         |備考           |
|:-----------:|:------------:|:------------:|:------------:|
| system       | システム全体  |     /etc/gitconfig         |    -          |
|  global      | 該当ユーザーの全リポジトリ    |  ~/.gitconfig   |       ホーム直下       |
|   local      |        該当リポジト     |     repository/.git/config         |   リポジトリの.git直下           |
#### 個人の識別情報
```
 git config --global user.name "Sample Test"
 git config --global user.email kishimoto.naoki@lmi.ne.jp
```
           
#### Githubからクローン
```
git clone git@github.com:naoki-lmi/BookApp.git
```

### テスト環境(rails)について
#### アプリを動かす準備
##### Gemfile.lockを削除
```
 rm Gemfile.lock
```
##### Gemfileの読み込み
```
bundle install
```
```
bundle update
```
#### mysal2を使えるようにする
https://www.virment.com/rails-setup-mysql/
##### mysqlにログイン
```
mysql -u root -
```
##### root以外のユーザー作成
```
CREATE USER 'railsuser'@'localhost' IDENTIFIED BY 'Na0k1o428!';
```
##### 作成したrailsuserにデータベース作成やテーブル作成の権限を付与
```
GRANT ALL PRIVILEGES ON *.* TO 'railsuser'@'localhost';
FLUSH PRIVILEGES;

```
#### データベース作成
```
rails db:create
```
###### socketエラーが出た場合
```
mysql_config --socket
```
###### でsockの場所が合っているか、database.ymlで確認
#### テーブルの作成（マイグレーション)
```
rails db:migrate
```
#### 仮のデータを入れる
```
rails db:seed
```
#### git の初期化
```
git init
```
#### rails サーバを立ち上げて完成
```
rails s -b 0.0.0.0 -p （その時のポート
）```