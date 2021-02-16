#!/bin/bash

#cfp-dp-psql.sh <dbName> <dbUser> <dbPasswd> <osVersion>

#Build Parameters
echo "loading parameters" >> dbinstall.log
allowIP=172.31.0.0/16
db=$1
user=$2
dbPass=$3
osCheck=$4

#install process
cd /root/dsm/
if [ "$osCheck" == "RHEL8" ]; then 
  echo "installing database for $osCheck" >> dbinstall.log;  
  dnf install @postgresql:10 -y;
  /usr/bin/postgresql-setup --initdb;
  sed -i "s/#listen_addresses =.*/listen_addresses ='*'/g" /var/lib/pgsql/data/postgresql.conf;
  sed -i "a\host all  all  $allowIP trust" /var/lib/pgsql/data/pg_hba.conf;
  systemctl start postgresql;
  systemctl enable postgresql;
elif [ "$osCheck" == "RHEL7" ]; then
  echo "installing database for $osCheck" >> dbinstall.log;
  rpm -Uvh "https://yum.postgresql.org/10/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm";
  yum install -y postgresql10-server postgresql10;
  /usr/pgsql-10/bin/postgresql-10-setup initdb;
  sed -i "s/#listen_addresses =.*/listen_addresses ='*'/g" /var/lib/pgsql/10/data/postgresql.conf;
  sed -i "a\host all  all  $allowIP trust" /var/lib/pgsql/10/data/pg_hba.conf;
  systemctl start postgresql-10.service;
  systemctl enable postgresql-10.service;
else 
  echo "$osCheck not supported" >> dbinstall.log; 
fi
echo "installed $(psql --version) successfully" >> dbinstall.log
su -l postgres -c "psql -c 'CREATE DATABASE $db'"
su -l postgres -c "psql -c 'CREATE ROLE $user WITH PASSWORD '\''$dbPass'\'' LOGIN'"
su -l postgres -c "psql -c 'GRANT ALL PRIVILEGES ON DATABASE $db to $user'"
su -l postgres -c "psql -c 'GRANT ALL ON DATABASE $db TO $user'"
su -l postgres -c "psql -c 'GRANT CONNECT ON DATABASE $db TO $user'"
su -l postgres -c "psql -c 'ALTER ROLE $user CREATEDB CREATEROLE'"
date >> dbinstall.log