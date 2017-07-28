# == Class: veritas_hyperscale::db::schema
#
# The veritas_hyperscale::db::schema creates tables
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
class veritas_hyperscale::db::schema (
  $password = $password,
  $dbname   = $dbname,
  $user     = $user,
) {

  include ::openstacklib::defaults
  require veritas_hyperscale::db::mysql

  $mysql_cmd = "/usr/bin/mysql --user=${user} --password=${password} < "

  exec {'sql1':
    before  => Exec['sql2'],
    path    => '/usr/bin:/usr/sbin:/bin',
    creates => "/tmp/.hs_openstack_configured",
    command => "${mysql_cmd} /tmp/veritas_hyperscale/scripts/db/01_HyperScale.sql",
  }

  exec {'sql2':
    before  => Exec['sql3'],
    path    => '/usr/bin:/usr/sbin:/bin',
    creates => "/tmp/.hs_openstack_configured",
    command => "${mysql_cmd} /tmp/veritas_hyperscale/scripts/db/02_HyperScaleStatsSchema.sql",
  }

  exec {'sql3':
    before  => Exec['sql4'],
    path    => '/usr/bin:/usr/sbin:/bin',
    creates => "/tmp/.hs_openstack_configured",
    command => "${mysql_cmd} /tmp/veritas_hyperscale/scripts/db/03_HyperScaleWorkflow.sql",
  }

  exec {'sql4':
    path    => '/usr/bin:/usr/sbin:/bin',
    creates => "/tmp/.hs_openstack_configured",
    command => "${mysql_cmd} /tmp/veritas_hyperscale/scripts/db/51_HyperScaleAlertsDescription.sql",
  } -> file {"/tmp/.hs_openstack_configured":
    ensure  => 'present',
    path    => "/tmp/.hs_openstack_configured",
    owner   => 'heat-admin',
    group   => 'heat-admin',
    mode    => '644',
  }

}
