#!/bin/bash

set -x

# Create hadoop user-group
groupadd -r hadoop 

# Update .bashrc file for hadoop and hive users
for user in "hadoop" "hive"
do 
    echo "Processing user: ${user}"

    # Create user
    useradd -r -g hadoop ${user}
    user_home=/home/${user}

    # Create home folders
    mkdir -p "${user_home}"
    chown -R ${user}:hadoop ${user_home}/

    # Create and set ownership for the .bashrc_file
    bashrc_file="${user_home}/.bashrc"
    touch $bashrc_file
    cat /opt/bashrc_file.sh >> ${bashrc_file}
    chmod 777 $bashrc_file && chown -R ${user}:hadoop $bashrc_file

    # Passwordless ssh setup
    mkdir -p "${user_home}/.ssh"
    chown -R ${user}:hadoop /home/${user}/.ssh
    ssh-keygen -t rsa -P '' -f ${user_home}/.ssh/id_rsa 
    cat ${user_home}/.ssh/id_rsa.pub >> ${user_home}/.ssh/authorized_keys 
    chmod 0600 ${user_home}/.ssh/authorized_keys 
done

# Change ownership for hadoop and hive installs
chown -R hadoop:hadoop /opt/hadoop/
chown -R hive:hadoop /opt/hive/

# Update JAVA_HOME in hadoop-env.sh
_JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
sed -i "s|^# export JAVA_HOME=.*|export JAVA_HOME=${_JAVA_HOME}|" /opt/hadoop/etc/hadoop/hadoop-env.sh

# Change logging level for S3 - otherwise too much noise on console
sed -i 's/#log4j.logger.org.apache.hadoop.fs.s3a.S3AFileSystem=WARN/log4j.logger.org.apache.hadoop.fs.s3a.S3AFileSystem=WARN/' /opt/hadoop/etc/hadoop/log4j.properties