###
# Generic settings for HADOOP
###
export JAVA_HOME="/opt/java/jdk-1.8.0"
export HADOOP_HOME=${HADOOP_HOME}
export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
# export HADOOP_HEAPSIZE_MAX=
# export HADOOP_HEAPSIZE_MIN=
# export HADOOP_JAAS_DEBUG=true
export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true"
# export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true -Dsun.security.krb5.debug=true -Dsun.security.spnego.debug"
export HADOOP_OS_TYPE=${HADOOP_OS_TYPE:-$(uname -s)}

case ${HADOOP_OS_TYPE} in
  Darwin*)
    export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.realm= "
    export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.kdc= "
    export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.conf= "
  ;;
esac

# export HADOOP_CLIENT_OPTS=""
# Similarly, end users should utilize ${HOME}/.hadooprc . This variable should ideally only be used as a short-cut,
# export HADOOP_CLASSPATH="/some/cool/path/on/your/machine"
# export HADOOP_USER_CLASSPATH_FIRST="yes"

# Ignore Above Variable
# export HADOOP_USE_CLIENT_CLASSLOADER=true
# export HADOOP_CLIENT_CLASSLOADER_SYSTEM_CLASSES="-org.apache.hadoop.UserClass,java.,javax.,org.apache.hadoop."
# export HADOOP_OPTIONAL_TOOLS="hadoop-azure-datalake,hadoop-azure,hadoop-openstack,hadoop-kafka,hadoop-aws,hadoop-aliyun"

###
# Options for remote shell connectivity
###

# start-dfs.sh will attempt to bring up all NNs, DNS, etc.

# Options to pass to SSH when one of the "log into a host and start/stop daemons" scripts is executed
# export HADOOP_SSH_OPTS="-o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=10s"

# The built-in ssh handler will limit itself to 10 simultaneous connections.
# export HADOOP_SSH_PARALLEL=10

# export HADOOP_WORKERS="${HADOOP_CONF_DIR}/workers"

###
# Options for all daemons
###
#

# export HADOOP_LOG_DIR=${HADOOP_HOME}/logs
# Java property: hadoop.id.str
# export HADOOP_IDENT_STRING=$USER

# export HADOOP_STOP_TIMEOUT=5
# export HADOOP_PID_DIR=/tmp

# Java property: hadoop.root.logger
# export HADOOP_ROOT_LOGGER=INFO,console

# Java property: hadoop.root.logger
# export HADOOP_DAEMON_ROOT_LOGGER=INFO,RFA

# Java property: hadoop.security.logger
# export HADOOP_SECURITY_LOGGER=INFO,NullAppender

# export HADOOP_NICENESS=0

# Java property: hadoop.policy.file
# export HADOOP_POLICYFILE="hadoop-policy.xml"

#
# NOTE: this is not used by default!  <-----
# You can define variables right here and then re-use them later on.
# For example, it is common to use the same garbage collection settings
# for all the daemons.  So one could define:
#
# export HADOOP_GC_SETTINGS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps"

###
# Secure/privileged execution
###

# export JSVC_HOME=/usr/bin
# export HADOOP_SECURE_PID_DIR=${HADOOP_PID_DIR}

# Java property: hadoop.log.dir
# export HADOOP_SECURE_LOG=${HADOOP_LOG_DIR}
# export HADOOP_SECURE_IDENT_PRESERVE="true"

###
# NameNode specific parameters
###

# Java property: hdfs.audit.logger
# export HDFS_AUDIT_LOGGER=INFO,NullAppender
#
# a) Set JMX options
# export HDFS_NAMENODE_OPTS="-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=1026"
#
# b) Set garbage collection logs
# export HDFS_NAMENODE_OPTS="${HADOOP_GC_SETTINGS} -Xloggc:${HADOOP_LOG_DIR}/gc-rm.log-$(date +'%Y%m%d%H%M')"
#
# c) ... or set them directly
# export HDFS_NAMENODE_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -Xloggc:${HADOOP_LOG_DIR}/gc-rm.log-$(date +'%Y%m%d%H%M')"

# this is the default:
# export HDFS_NAMENODE_OPTS="-Dhadoop.security.logger=INFO,RFAS"

###
# SecondaryNameNode specific parameters
###

# This is the default:
# export HDFS_SECONDARYNAMENODE_OPTS="-Dhadoop.security.logger=INFO,RFAS"

###
# DataNode specific parameters
###

# export HDFS_DATANODE_OPTS="-Dhadoop.security.logger=ERROR,RFAS"

# This will replace the hadoop.id.str Java property in secure mode.
# export HDFS_DATANODE_SECURE_USER=hdfs
# export HDFS_DATANODE_SECURE_EXTRA_OPTS="-jvm server"

###
# NFS3 Gateway specific parameters
###
# export HDFS_NFS3_OPTS=""
# export HDFS_PORTMAP_OPTS="-Xmx512m"
# export HDFS_NFS3_SECURE_EXTRA_OPTS="-jvm server"

# This will replace the hadoop.id.str Java property in secure mode.
# export HDFS_NFS3_SECURE_USER=nfsserver

###
# ZKFailoverController specific parameters
###

# export HDFS_ZKFC_OPTS=""

###
# QuorumJournalNode specific parameters
###
# export HDFS_JOURNALNODE_OPTS=""

###
# HDFS Balancer specific parameters
###
# export HDFS_BALANCER_OPTS=""

###
# HDFS Mover specific parameters
###
# export HDFS_MOVER_OPTS=""

###
# Router-based HDFS Federation specific parameters
# Specify the JVM options to be used when starting the RBF Routers.
# These options will be appended to the options specified as HADOOP_OPTS
# and therefore may override any similar flags set in HADOOP_OPTS
#
# export HDFS_DFSROUTER_OPTS=""
###

###
# Advanced Users Only!
###

#
# When building Hadoop, one can add the class paths to the commands
# via this special env var:
# export HADOOP_ENABLE_BUILD_PATHS="true"

#
# To prevent accidents, shell commands be (superficially) locked
# to only allow certain users to execute certain subcommands.
# It uses the format of (command)_(subcommand)_USER.
#
# For example, to limit who can execute the namenode command,
# export HDFS_NAMENODE_USER=hdfs
