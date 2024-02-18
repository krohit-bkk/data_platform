# Home paths for tools
JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
HADOOP_HOME=/opt/hadoop
HIVE_HOME=/opt/hive

# Copy S3 dependencies to $HIVE_HOME/lib
cp ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.1.0.jar $HIVE_HOME/lib 
cp ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.271.jar $HIVE_HOME/lib

