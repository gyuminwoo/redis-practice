# Redisのインストール（Linux）
sudo apt-get install redis-server

# Redisに接続
redis-cli

# RedisのDockerインストール（Windows、Mac）
docker run --name redis-container -d -p 6379:6379 redis

# Dockerコンテナの一覧を確認
docker ps

# Redisコンテナに接続
docker exec -it <containerID> redis-cli

# Redisは0〜15番までのデータベースで構成されている（デフォルトは0番）
# データベースを選択
select db번호

# データベース内のすべてのキーを取得
keys *

# 一般的なStringデータ構造

# setコマンドでkeyとvalueを設定
set user:email:1 min1@gmail.com
set user:email:2 "min2@gmail.com"

# nxオプション：既に存在していればスキップ、存在しなければset
set user:email:1 min1@gmail.com nx

# exオプション：有効期限を秒単位で指定 - ttl（time to live）
set user:email:1 min1@gmail.com ex 10

# Redisの活用例：リフレッシュトークンなど、ユーザー認証情報を保存
set user:1:refresh_token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9 ex 100000

# 特定のキーを削除
del user:email:1

# 現在のデータベース内のすべてのキーを削除
flushdb

# Redisの活用：いいね機能
# 普通はライブラリを使ってRedisを操作する
# 今回はRedisの基本を学ぶために手動でコマンドを入力
set likes:posting:1 0
incr likes:posting:1 # 特定のキーの値を1インクリメントする
decr likes:posting:1 # 特定のキーの値を1デクリメントする
get likes:posting:1

# Redisの活用：在庫管理
set stocks:product:1 100
decr stocks:product:1
get stocks:product:1

# Redisの活用：キャッシュ機能
# データベースから取得した値をJSON形式に変換して一時的に保存
set posting:1 "{\"title\":\"hello java\", \"contents\":\"hello java is ...\", \"author_email\":\"min1@gmail.com\" }" ex 100
get posting:1

# list構造：Redisのlistはdeque構造
# lpush：左端にデータを追加
# rpush：右端にデータを追加
# lpop：左端からデータを取り出す
# rpop：右端からデータを取り出す
lpush honggildongs hong1
lpush honggildongs hong2
rpush honggildongs hong3

# listの参照
# -1はリストの最後の要素を示す（-2は最後から2番目の要素を示す）
lrange honggildongs 0 0 #最初の要素だけ取得
lrange honggildongs -1 -1 #最後の要素だけ取得
lrange honggildongs 0 -1 #最初から最後まで取得
lrange honggildongs -2 -1 #最後から2番目∼最後まで取得
lrange honggildongs 0 1 #最初から2番目まで取得

# データの個数を取得
llen honggildongs

# TTL（有効期限）設定
expire honggildongs 20

# TTL確認
ttl honggildongs

# Redisの活用：最近訪問したぺーじ、最近閲覧した商品リスト
lpush mypages www.naver.com
lpush mypages www.google.com
lpush mypages www.daum.net
lpush mypages www.yahoo.com

# 最近訪問したぺーじを3件表示
lrange mypages 0 2