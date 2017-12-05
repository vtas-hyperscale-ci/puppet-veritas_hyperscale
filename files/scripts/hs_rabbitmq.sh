#!/bin/bash
#
# === Authors
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.

echo "Started executing script" > /tmp/hs_rabbitmq.log
PASS=$1

CMD_RABBITMQA_PLUGIN=/usr/lib/rabbitmq/bin/rabbitmq-plugins
CMD_RABBITMQCTL=/usr/sbin/rabbitmqctl
CMD_RABBITMQADMIN="python /etc/puppet/modules/veritas_hyperscale/files/scripts/rabbitmqadmin"

usr=`$CMD_RABBITMQCTL list_users | grep hyperscale | awk '{print $1}'`
if [ "X$usr" != "Xhyperscale" ]
then
    echo "hyperscale user not found" >> /tmp/hs_rabbitmq.log
    echo "Exiting script" >> /tmp/hs_rabbitmq.log
    exit 1
fi
# Add user tags
$CMD_RABBITMQCTL set_user_tags hyperscale management

# Delete stale configuration.
$CMD_RABBITMQADMIN delete exchange name=hyperscale-controller -u hyperscale -p $PASS
$CMD_RABBITMQADMIN delete exchange name=hyperscale-stats -u hyperscale -p $PASS
$CMD_RABBITMQADMIN delete exchange name=hyperscale-recv -u hyperscale -p $PASS
$CMD_RABBITMQADMIN delete exchange name=hyperscale-storage -u hyperscale -p $PASS
$CMD_RABBITMQADMIN delete exchange name=hyperscale-datanode -u hyperscale -p $PASS
$CMD_RABBITMQADMIN delete exchange name=hyperscale-compute-hy -u hyperscale -p $PASS
$CMD_RABBITMQADMIN delete exchange name=hyperscale-datanode-hypervisor -u hyperscale -p $PASS

# Create rabbitmq exchanges for hyperscale.
$CMD_RABBITMQADMIN declare exchange name=hyperscale-controller type=direct durable=true -u hyperscale -p $PASS
$CMD_RABBITMQADMIN declare exchange name=hyperscale-stats type=direct durable=true -u hyperscale -p $PASS
$CMD_RABBITMQADMIN declare exchange name=hyperscale-datanode type=direct durable=true -u hyperscale -p $PASS
$CMD_RABBITMQADMIN declare exchange name=hyperscale-recv type=direct durable=true -u hyperscale -p $PASS
$CMD_RABBITMQADMIN declare exchange name=hyperscale-storage type=direct durable=true -u hyperscale -p $PASS
$CMD_RABBITMQADMIN declare exchange name=hyperscale-compute-hy type=direct durable=true -u hyperscale -p $PASS
$CMD_RABBITMQADMIN declare exchange name=hyperscale-datanode-hypervisor type=direct durable=true -u hyperscale -p $PASS

exch_count=`$CMD_RABBITMQCTL list_exchanges | grep hyperscale |wc -l`
if [ "X$exch_count" != "X7" ]
then
    echo "hyperscale exchanges creation failed" >> /tmp/hs_rabbitmq.log
    echo "Exiting script" >> /tmp/hs_rabbitmq.log
    exit 1
fi

echo "Exiting on successful execution of script" >> /tmp/hs_rabbitmq.log
