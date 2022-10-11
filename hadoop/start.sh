#! /bin/bash
HADOOP_HOME=/hadoop
JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
HADOOP_INSTALL=$HADOOP_HOME
HADOOP_MAPRED_HOME=$HADOOP_HOME
HADOOP_COMMON_HOME=$HADOOP_HOME
HADOOP_HDFS_HOME=$HADOOP_HOME
YARN_HOME=$HADOOP_HOME
HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native

until kinit -kt /var/keytabs/hdfs.keytab hdfs/hadoop.example.com; do sleep 2; done
echo "KDC is up and ready to go... starting up"
kdestroy

rm -f /var/keytabs/hdfs.jks

keytool -genkey -alias hadoop -keyalg rsa -keysize 1024 -dname "CN=hadoop.example.com" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme
chmod 700 /var/keytabs/hdfs.jks
chown root /var/keytabs/hdfs.jks

echo "N" | hdfs namenode -format
/hadoop/sbin/start-dfs.sh
/hadoop/sbin/start-yarn.sh

/bin/bash