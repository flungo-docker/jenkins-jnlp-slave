#!/bin/sh

set -e

# Enable debug if requested
if [ "${DEBUG}" = "true" ]; then
  set -x
fi

# If command is provided run that
if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

# Initialise JENKINS_SLAVE_OPTS
JENKINS_SLAVE_OPTS=(${JENKINS_SLAVE_OPTS})

# Verify there is a JENKINS_URL
if [ -z "${JENKINS_URL}" ]; then
  >&2 echo "JENKINS_URL must be set"
  exit 1
fi

# Verify there is a JENKINS_SLAVE_NAME
if [ -z "${JENKINS_SLAVE_NAME}" ]; then
  >&2 echo "JENKINS_SLAVE_NAME must be set"
  exit 1
fi

# Set the -jnlpUrl flag
JENKINS_SLAVE_OPTS+=(-jnlpUrl "${JENKINS_URL}/computer/${JENKINS_SLAVE_NAME}/slave-agent.jnlp")

# If a JENKINS_SLAVE_SECRET is given, add that to the JENKINS_SLAVE_OPTS
if [ -n "${JENKINS_SLAVE_SECRET}" ]; then
  JENKINS_SLAVE_OPTS+=(-secret "${JENKINS_SLAVE_SECRET}")
fi

# Get the slave JAR
wget "${JENKINS_URL}/jnlpJars/slave.jar"

# Run the slave
exec java -jar slave.jar  "$@"
