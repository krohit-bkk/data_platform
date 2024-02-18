#!/bin/sh

set -x

# # Setup bashrc for hadoop and hive
# bash /opt/hadoop-setup.sh

# Start the ssh server
service ssh start
service ssh status

# Start hadoop services
su - hadoop 
ssh localhost

# Format the hdfs - otherwise namenode won't start
/opt/hadoop/bin/hdfs namenode -format
# Start all services
/opt/hadoop/sbin/start-dfs.sh

# Execute the CMD
exec "$@"