JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
HADOOP_HOME=/opt/hadoop
HIVE_HOME=/opt/hive

alias ll='ls -lrt'
export JAVA_HOME=${JAVA_HOME}
export HADOOP_HOME=${HADOOP_HOME} 
export HIVE_HOME=${HIVE_HOME} 
export PDSH_RCMD_TYPE=ssh

# PATH MODIFICATIONS 
# ################## 
export PATH=$PATH:$HADOOP_HOME/bin 
export PATH=$PATH:$HADOOP_HOME/sbin 
export HIVE_HOME=${HIVE_HOME} 

 

# HADOOP CONFIGURATIONS 
# ##################### 
# export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/opt/hadoop/share/hadoop/tools/lib/hadoop-aws-3.1.0.jar:/opt/hadoop/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.271.jar
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.1.0.jar:${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.271.jar
export HADOOP_MAPRED_HOME=$HADOOP_HOME 
export YARN_HOME=$HADOOP_HOME 
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop 
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native 
export HADOOP_OPTS='-Djava.library.path=$HADOOP_HOME/lib/native' 
export HADOOP_STREAMING=$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.1.0.jar 
export HADOOP_LOG_DIR=$HADOOP_HOME/logs 
export PDSH_RCMD_TYPE=ssh 


# HIVE CONFIGURATIONS 
# ################### 