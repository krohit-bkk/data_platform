docker exec -it -u 0 hadoop bash

service ssh start
ssh localhost


docker exec -it hadoop bash

/opt/hadoop/sbin/start-dfs.sh


# S3 Specifics
export HADOOP_HOME="/opt/hadoop"
export HIVE_HOME="/opt/hive"
export PATH=$PATH:$HADOOP_HOME/bin:$HIVE_HOME/bin

# Reference
# https://codewitharjun.medium.com/install-hadoop-on-ubuntu-operating-system-6e0ca4ef9689
# https://www.linkedin.com/pulse/how-run-hadoop-workload-minio-object-storage-nandha-k-subramaniam/
# https://github.com/arempter/hive-metastore-docker
# https://medium.com/@adamrempter/running-spark-3-with-standalone-hive-metastore-3-0-b7dfa733de91
# Hadoop core-site.xml - $HADOOP_HOME/etc/hadoop/core-site.xml
  <property>
    <name>fs.s3a.endpoint</name>
    <description>MinIO Bucket S3 endpoint to connect to.</description>
    <value>http://minio-server:9000</value>
  </property>
  <property>
    <name>fs.s3a.access.key</name>
    <description>MinIO Bucket access key ID.</description>
    <value>minioaccesskey</value>
  </property>
  <property>
    <name>fs.s3a.secret.key</name>
    <description>MinIO Bucket secret key.</description>
    <value>miniosecretkey</value>
  </property>
  <property>
    <name>fs.s3a.path.style.access</name>
    <value>true</value>
    <description>Enable S3 path style access.</description>
  </property>


# Add jars to /opt/hadoop/share/hadoop/common/lib
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.1.0/hadoop-aws-3.1.0.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.11.406/aws-java-sdk-1.11.406.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.11.234/aws-java-sdk-core-1.11.234.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-dynamodb/1.11.234/aws-java-sdk-dynamodb-1.11.234.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-kms/1.11.234/aws-java-sdk-kms-1.11.234.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.406/aws-java-sdk-s3-1.11.406.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.3/httpclient-4.5.3.jar
wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/joda-time/joda-time/2.9.9/joda-time-2.9.9.jar

wget -P /opt/hadoop/share/hadoop/common/lib/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.406/aws-java-sdk-s3-1.11.406.jar




# Define Users
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_NODEMANAGER_USER=root
export YARN_RESOURCEMANAGER_USER=root

# Add JAVA_HOME TO hadoop-env.sh
cp $HADOOP_HOME/etc/hadoop/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh_BCKP

_JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
sed -i "s|^# export JAVA_HOME=.*|export JAVA_HOME=${_JAVA_HOME}|" $HADOOP_HOME/etc/hadoop/hadoop-env.sh



# Start dfs 
apt-get install -y procps ssh openssh-server
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

service ssh start

$HADOOP_HOME/sbin/start-dfs.sh