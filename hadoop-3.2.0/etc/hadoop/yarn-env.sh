## THIS FILE ACTS AS AN OVERRIDE FOR hadoop-env.sh FOR ALL
## WORK DONE BY THE yarn AND RELATED COMMANDS.

###
# Resource Manager specific parameters
###

#export YARN_RESOURCEMANAGER_HEAPSIZE=

# Specify the JVM options to be used when starting the ResourceManager.
# These options will be appended to the options specified as HADOOP_OPTS
# and therefore may override any similar flags set in HADOOP_OPTS
#
# Examples for a Sun/Oracle JDK:
# a) override the appsummary log file:
# export YARN_RESOURCEMANAGER_OPTS="-Dyarn.server.resourcemanager.appsummary.log.file=rm-appsummary.log -Dyarn.server.resourcemanager.appsummary.logger=INFO,RMSUMMARY"
#
# b) Set JMX options
# export YARN_RESOURCEMANAGER_OPTS="-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=1026"
#
# c) Set garbage collection logs from hadoop-env.sh
# export YARN_RESOURCE_MANAGER_OPTS="${HADOOP_GC_SETTINGS} -Xloggc:${HADOOP_LOG_DIR}/gc-rm.log-$(date +'%Y%m%d%H%M')"
#
# d) ... or set them directly
# export YARN_RESOURCEMANAGER_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -Xloggc:${HADOOP_LOG_DIR}/gc-rm.log-$(date +'%Y%m%d%H%M')"
#

# export YARN_RESOURCEMANAGER_OPTS=

###
# Node Manager specific parameters
###

#export YARN_NODEMANAGER_HEAPSIZE=
#export YARN_NODEMANAGER_OPTS=

###
# TimeLineServer specific parameters
###

#export YARN_TIMELINE_HEAPSIZE=
#export YARN_TIMELINESERVER_OPTS=

###
# TimeLineReader specific parameters
###

#export YARN_TIMELINEREADER_OPTS=

###
# Web App Proxy Server specifc parameters
###

#export YARN_PROXYSERVER_HEAPSIZE=
#export YARN_PROXYSERVER_OPTS=

###
# Shared Cache Manager specific parameters
###
#export YARN_SHAREDCACHEMANAGER_OPTS=

###
# Router specific parameters
###
#export YARN_ROUTER_OPTS=

###
# Registry DNS specific parameters
###
# export YARN_REGISTRYDNS_SECURE_USER=yarn
# export YARN_REGISTRYDNS_SECURE_EXTRA_OPTS="-jvm server"

###
# YARN Services parameters
###
# Directory containing service examples
# export YARN_SERVICE_EXAMPLES_DIR = $HADOOP_YARN_HOME/share/hadoop/yarn/yarn-service-examples
# export YARN_CONTAINER_RUNTIME_DOCKER_RUN_OVERRIDE_DISABLE=true
