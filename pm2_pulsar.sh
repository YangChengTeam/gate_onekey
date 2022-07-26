#!/bin/sh
pm2 start --name pulsar --interpreter bash "/opt/apache-pulsar-2.10.0/bin/pulsar" -- standalone
cd /opt/pulsar-manager/pulsar-manager
pm2 start --name pulsar-manager --interpreter bash "/opt/pulsar-manager/pulsar-manager/bin/pulsar-manager"
