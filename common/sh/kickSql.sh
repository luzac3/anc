#! /bin/bash

#ファイルパス
path=$1
user=$2
host=$3
password=$4
dbname=$5

# sqlファイル実行
mysql -u $user -h $host -p$password $dbname < $path

exit