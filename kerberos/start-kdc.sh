#! /bin/bash

rm /var/keytabs/admin.keytab -f
rm /var/keytabs/hdfs.keytab -f
rm /etc/krb5kdc/kadm5.acl -f

kdb5_util -P changeme create -s

kadmin.local -q "addprinc -pw changeme admin"

kadmin.local -q "addprinc -randkey hdfs@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey hdfs/admin@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey hdfs/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey HTTP/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey yarn/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey jhs/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey host/hadoop.example.com@EXAMPLE.COM"

kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs@EXAMPLE.COM"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/admin@EXAMPLE.COM"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab yarn/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab jhs/hadoop.example.com@EXAMPLE.COM"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab host/hadoop.example.com@EXAMPLE.COM"


chown rootE /var/keytabs/hdfs.keytab

echo "admin *" >> /etc/krb5kdc/kadm5.acl

service krb5-admin-server restart && service krb5-kdc restart
/bin/bash