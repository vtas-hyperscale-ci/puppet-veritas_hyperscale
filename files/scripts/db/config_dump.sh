#!/bin/bash

if [ $# -ne 4 ]
then
  echo "ERROR config_dump: Invalid number of parameters."
  exit -1
fi

touch /tmp/.config_dump

user=$1
passwd=$2
key=$3
value=$4

/usr/bin/mysql --user=${user} --password=${passwd} -e "INSERT INTO HyperScale.hyperscale_config_metadata (host_ip, host_id, personality, config_key, config_value) VALUES ('NULL', 'NULL', 'CONTROLLER', '${key}', '${value}') ON DUPLICATE KEY UPDATE host_ip='NULL', host_id='NULL', personality='CONTROLLER', config_key='${key}', config_value='${value}'"

exit $?
