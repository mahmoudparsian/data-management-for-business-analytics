#echo 'Environment:' && env

echo 'Loading employee database...'
cd /initdb/test_db
mysql -uroot -p < initdb.sql
