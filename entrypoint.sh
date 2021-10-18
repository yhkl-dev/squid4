#!/bin/bash
# encoding: utf-8
set -e

CHOWN=chown
SQUID=/usr/local/squid/sbin/squid

useradd -M -s /sbin/nologin squid
# Ensure permissions are set correctly on the Squid cache + log dir.
"$CHOWN" -R squid:squid /usr/local/squid/var/cache/squid
"$CHOWN" -R squid:squid /usr/local/squid/var/logs

# Prepare the cache using Squid.
echo "Initializing cache..."
"$SQUID" -z

# Give the Squid cache some time to rebuild.
sleep 5

# Launch squid
echo "Starting Squid..."
exec "$SQUID" -NYCd 1