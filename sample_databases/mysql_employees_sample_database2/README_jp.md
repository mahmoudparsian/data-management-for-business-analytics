# mysql8.0-employees

[English](./README.md) | 日本語

dockerhub url: https://hub.docker.com/r/ac0mz/mysql8.0-employees

## 概要
このDockerイメージは[genschsa/mysql-employees](https://hub.docker.com/r/genschsa/mysql-employees)を参考に、M1 Macで動作するように構築されています。

コンテナ起動時に[MySQL Employee Sampleデータベース](https://dev.mysql.com/doc/employee/en/)に基づいたテーブルを作成し、データ投入しているため、開発用途やMySQLの練習として即時利用可能なイメージとなっています。github上の[datacharmer/test_db](https://github.com/datacharmer/test_db)リポジトリのDDLを使用してデータを投入します。

これは[MySQLが公開しているmysql-server8.0のDockerイメージ](https://hub.docker.com/r/mysql/mysql-server)をベースとしています。

ポートとして3306を公開し、永続データ用として `/var/lib/mysql` にボリュームをマウントしています。


## コンテナイメージ自作方法
自身でコンテナイメージを作成する場合は以下コマンドを実施してください。

```sh
# mysql-employeesがカレントディレクトリであることを確認する
pwd
# > /Users/YOUR_NAME/mysql-employees

# データ投入用DDLの用意
git clone https://github.com/datacharmer/test_db.git

# コンテナ起動後に自動実行されるスクリプトの作成
mkdir docker-entrypoint-initdb.d && cd $_
cat <<EOF > initdb.sh
#echo 'Environment:' && env

echo 'Loading employee database...'
cd /initdb/test_db
mysql -uroot -p$MYSQL_ROOT_PASSWORD < initdb.sql
EOF

# mysqlユーザー作成用DDLの作成
# 外部クライアントから接続可能とするため、mysql_native_passwordでパスワードを作成する
cd - && mkdir initdb && cd $_
cat <<EOF > users.sql
SELECT 'Configuring Users...' as 'INFO';

CREATE USER sa_empapi@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT SELECT ON employees.* TO sa_empapi@'%';

CREATE USER sa_empmsg@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT SELECT, INSERT, UPDATE, DELETE ON employees.* TO sa_empmsg@'%';

CREATE USER emp_api_web@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT ALL PRIVILEGES ON employees.* TO emp_api_web@'%';

CREATE USER gnuser@'%' IDENTIFIED WITH mysql_native_password BY 'college';
GRANT ALL PRIVILEGES ON employees.* TO gnuser@'%' WITH GRANT OPTION;
EOF

# datacharmer/test_dbからDDLをコピー
mkdir test_db && cd ../test_db
cp employees.sql load_departments.dump load_dept_emp.dump load_dept_manager.dump load_employees.dump load_salaries1.dump load_salaries2.dump load_salaries3.dump load_titles.dump objects.sql show_elapsed.sql sql_test.sh test_employees_md5.sql test_employees_sha.sql ../initdb/test_db
cd ../../

# コンテナイメージを作成する
docker image build -t mysql-employees:8.0.27-aarch64 .
```


## 使い方
```sh
# バックグラウンドで起動する(--rm オプションによりコンテナ停止と共にコンテナを削除する)
docker container run -d --rm \
  --name mysql-employee-v8 \
  -p 33060:3306 \
  -e MYSQL_ROOT_PASSWORD=college \
  -v $PWD/data:/var/lib/mysql \
  mysql-employees:8.0.27-aarch64

# コンテナのステータスを確認し、[health: starting] -> [healthy] になるまで待機する
docker container ls

# コンテナに接続する
docker container exec -it mysql-employee-8 bash

# mysqlに接続する(パスワードはコンテナ起動時に環境変数として設定済)
mysql -uroot -p$MYSQL_ROOT_PASSWORD employees
# レコードが取得できることを確認する
select * from employees limit 5;
```


## 補足

### MySQL5.7のイメージは作成不可能
M1 Macの対象プラットフォームである linux/arm64 (aarch64) に関して、こちらの[MySQL5.7公式ページ](https://dev.mysql.com/doc/refman/5.7/en/linux-installation-yum-repo.html)では説明が見つからず、[MySQL8.0公式ページ](https://dev.mysql.com/doc/refman/8.0/ja/linux-installation-yum-repo.html)には以下の記載があります。

>ARM 64-bit (aarch64) は、MySQL 8.0.12 の Oracle Linux 7 でサポートされています。

つまり、M1 Mac対応のMySQL5.7のイメージは作成することができません。

また[MySQLの公式Dockerイメージ](https://hub.docker.com/_/mysql/)では linux/amd64 (x86_64) のみ提供されており、M1 Macで使用するべきは linux/arm64 プラットフォームでも提供されている[mysql-server](https://hub.docker.com/r/mysql/mysql-server)となります。MySQL8.0以上で linux/arm64 が提供されています。


### 初期データの投入
ベースイメージではコンテナ内の `/docker-entrypoint-initdb.d` 配下に存在するスクリプトをコンテナ起動時に自動で実行するよう構成されています。

そのためDockerfileにおいてデータ投入用スクリプトを `/docker-entrypoint-initdb.d` にコピーしています。
スクリプト内で `/init/test_db/initdb.sql` をMySQLに流し込むことで、データ投入を実現しています。

詳細は当該ページの[Make-own-yourself](#Make-own-yourself)の記載内容をご参照ください。

