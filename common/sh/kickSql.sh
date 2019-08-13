#! /bin/bash

# sqlファイル実行
mysql -u [user] -p[password] [dbname] < $1

exit