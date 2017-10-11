# == Class: rabbitmq_save_conf
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#

class veritas_hyperscale::rabbitmq_save_conf (
)inherits veritas_hyperscale
{
  # Add MQ info to the conf
  $amqp_conf_file = '/opt/VRTSofcore/etc/amqp.conf'

  $rabbit_port = hiera('rabbitmq::port', '')
  if $rabbit_port == '' {
    fail("Rabbitmq port not set.")
  }

  $ctrl_ip = hiera('vrts_ctrl_mgmt_ip', '')
  if $ctrl_ip == '' {
    fail("vrts_ctrl_mgmt_ip IP not set.")
  }

  $rabbit_pass = hiera('vrts_rabbitmq_pass', 'elacsrepyh')

  exec {'dump_rabbitmq_conf':
    path   => '/usr/bin:/usr/sbin:/bin',
    command => "/bin/sed -i \"s|5672|$rabbit_port|g\" $amqp_conf_file && /bin/sed -i \"s|RABBITMQ_USER|hyperscale|g\" $amqp_conf_file && /bin/sed -i \"s|RABBITMQ_PASSWORD|$rabbit_pass|g\" $amqp_conf_file && /bin/sed -i \"s|MGMT_SERVER_IP|$ctrl_ip|g\" $amqp_conf_file",
  }
}
