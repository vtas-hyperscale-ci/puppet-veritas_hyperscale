# == Class: controller_service_start
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#

class veritas_hyperscale::controller_service_start (
)inherits veritas_hyperscale
{
  require veritas_hyperscale::controller_pkg_inst
  require veritas_hyperscale::controller_save_conf
  require veritas_hyperscale::hs_keystone
  require veritas_hyperscale::hs_rabbitmq
  require veritas_hyperscale::db::mysql

  service { 'hyperscale-mq-controller':
    ensure => running,
    enable => true,
  }

  service { 'hyperscale-mq-consumer':
    ensure => running,
    enable => true,
  }

  service { 'hyperscale-zookeeper':
    ensure => running,
    enable => true,
  }

  service { 'hyperscale-serengeti':
    ensure => running,
    enable => true,
  }

  service { 'hyperscale-api':
    ensure => running,
    enable => true,
  }
}
