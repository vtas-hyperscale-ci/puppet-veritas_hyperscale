# == Class: veritas_hyperscale::db::config_save
#
# The veritas_hyperscale::db::config_save creates tables
# in HyperScale databases.
#
# === Parameters
#
# [*password*]
#   password to connect to the database. Mandatory.
#
# [*dbname*]
#   "HyperScale"
#
# [*user*]
#   "hyperscale"
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class veritas_hyperscale::db::config_save (
  $password = 'pass12345',
  $dbname   = 'HyperScale',
  $user     = 'hyperscale',
) {

  $path = '/tmp/veritas_hyperscale/'

  include ::openstacklib::defaults
  #require veritas_hyperscale::db::schema

  $ctrl_ip = hiera('controller_virtual_ip', '')
  if $ctrl_ip == '' {
    fail("Controller IP not set.")
  }

  exec {'ctrl_ip':
    path    => '/usr/bin:/usr/sbin:/bin',
    command => "$path/scripts/db/config_dump.sh ${user} ${password} HYPERVISOR_IP ${ctrl_ip}",
  }

}
