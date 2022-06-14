#
# Add cluster specific environment variables in this file.
#

# Password for all keystore files including cluster and client keystores.
KEYSTORE_PASSWORD=sorint

#
# Set Java options, i.e., -Dproperty=xyz
#
#JAVA_OPTS=

#
# To use Hibernate backed MapStorePkDbImpl, set the following property and
# configure MapStorePkDbImpl in the $CLUSTER_DIR/etc/hazelcast.xml file.
# MySQL and PostgreSQL Hibernate configuration files are provided to get
# you started. You should copy one of them and enter your DB information.
# You can include your JDBC driver in the ../pom.xml file and run ./build_app
# which downloads and places it in the $PADOGRID_WORKSPACE/lib
# directory. CLASSPATH includes all the jar files in that directory for
# the apps and clusters running in this workspace.
#
#JAVA_OPTS="$JAVA_OPTS -Dpadogrid.hibernate.config=$CLUSTER_DIR/etc/hibernate.cfg-mysql.xml"
#JAVA_OPTS="$JAVA_OPTS -Dpadogrid.hibernate.config=$CLUSTER_DIR/etc/hibernate.cfg-postgresql.xml"

JAVA_OPTS="$JAVA_OPTS \
-DkeyStore=$CLUSTER_DIR/etc/ssl/wan.keystore \
-DkeyStorePassword=$KEYSTORE_PASSWORD \
-DkeyStoreType=pkcs12 \
-DtrustStore=$CLUSTER_DIR/etc/ssl/wan-trust.keystore \
-DtrustStorePassword=$KEYSTORE_PASSWORD \
-DtrustStoreType=pkcs12"
#-Djavax.net.debug=SSL"

#
# Set Management Center Java options, i.e., -Dhazelcast.mc.forceLogoutOnMultipleLogin=true
#
# Enable Management Center TLS with the cluster's keystores
MC_JAVA_OPTS="-Dhazelcast.mc.tls.enabled=true \
-Dhazelcast.mc.tls.keyStore=$CLUSTER_DIR/etc/ssl/wan.keystore \
-Dhazelcast.mc.tls.keyStorePassword=$KEYSTORE_PASSWORD \
-Dhazelcast.mc.tls.trustStore=$CLUSTER_DIR/etc/ssl/wan-trust.keystore \
-Dhazelcast.mc.tls.trustStorePassword=$KEYSTORE_PASSWORD \
-Djavax.net.debug=SSL"

#
# Set RUN_SCRIPT. Absolute path required.
# If set, the 'start_member' command will run this script instead of com.hazelcast.core.server.StartServer.
# Your run script will inherit the following:
#    JAVA      - Java executable.
#    JAVA_OPTS - Java options set by padogrid.
#    CLASSPATH - Class path set by padogrid. You can include additional libary paths.
#                You should, however, place your library files in the plugins directories
#                if possible.
#
# Run Script Example:
#    "$JAVA" $JAVA_OPTS com.newco.MyMember &
#
# Although it is not required, your script should be placed in the bin_sh directory.
#
#RUN_SCRIPT=$CLUSTER_DIR/bin_sh/your-script
#JAVA_OPTS="$JAVA_OPTS -Djdk.internal.httpclient.disableHostnameVerification=true"
JAVA_OPTS="$JAVA_OPTS \
-Djavax.net.ssl.keyStore=$CLUSTER_DIR/etc/ssl/wan.keystore \
-Djavax.net.ssl.keyStorePassword=$KEYSTORE_PASSWORD \
-Djavax.net.ssl.keyStoreType=pkcs12 \
-Djavax.net.ssl.trustStore=$CLUSTER_DIR/etc/ssl/wan-trust.keystore \
-Djavax.net.ssl.trustStorePassword=$KEYSTORE_PASSWORD \
-Djavax.net.ssl.trustStoreType=pkcs12"

# Turn off Moby naming
JAVA_OPTS="$JAVA_OPTS -Dhazelcast.member.naming.moby.enabled=false"
# Turn off health monitoring logging
JAVA_OPTS="$JAVA_OPTS -Dhazelcast.health.monitoring.level=OFF"

# Member number >$FULL_MEMBER_COUNT are lite-members
FULL_MEMBER_COUNT=3

if [ $MEMBER_NUM_NO_LEADING_ZERO -gt $FULL_MEMBER_COUNT ]; then
   CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast-lite.yaml
else
   # YAML
   #CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast.yaml
   #CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast-get.yaml
   #CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast-session-metadata-delete.yaml
   CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast-session-metadata-get.yaml

   # XML
   #CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast.xml
   #CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast-get.xml
   #CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast-session-metadata-delete.xml
   #CONFIG_FILE=$CLUSTER_DIR/etc/hazelcast-session-metadata-get.xml
fi
