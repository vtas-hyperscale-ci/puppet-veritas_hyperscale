# == Class: veritas_hyperscale::db::mysql
#
# The veritas_hyperscale::db::mysql class creates a MySQL database for
# Veritas HyperScale. It must be used on the MySQL server
#
# === Parameters
#
# [*mysql_pass*]
#   Password to connect to the database.
#
# [*dbname*]
#   "HyperScale"
#
# [*user*]
#   "hyperscale"
#
# [*host*]
#   The default source host user is allowed to connect from.
#   Optional. Defaults to 'localhost'
#
# [*mysql_vip*]
#   The IP of mysql component.
#
# [*mysql_bind_host*]
#   Defaults to hiera('mysql_bind_host').
#
# [*allowed_hosts*]
#   Other hosts the user is allowd to connect from.
#   Optional. Defaults to undef.
#
# [*charset*]
#   The database charset. Optional. Defaults to 'utf8'
#
# [*collate*]
#   The database collation. Optional. Defaults to 'utf8_general_ci'
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class veritas_hyperscale::db::mysql (
  $mysql_pass      = hiera('vrts_mysql_passwd', ''),
  $dbname          = 'HyperScale',
  $user            = 'hyperscale',
  $host            = '127.0.0.1',
  $mysql_vip       = hiera('mysql_vip', hiera('controller_virtual_ip')),
  $mysql_bind_host = hiera('mysql_bind_host'),
  $allowed_hosts   = ['localhost', '%', "$mysql_vip", "$mysql_bind_host"],
  $charset         = 'utf8',
  $collate         = 'utf8_general_ci',
) {

  include ::openstacklib::defaults

  if $mysql_pass == '' {
    $password = 'elacsrepyh'
  } else {
    $password = $mysql_pass
  }

  ::openstacklib::db::mysql { 'HyperScale':
    user          => $user,
    password_hash => mysql_password($password),
    dbname        => $dbname,
    host          => $host,
    charset       => $charset,
    collate       => $collate,
    allowed_hosts => $allowed_hosts,
  }

  mysql_grant { "hyperscale@localhost/nova.*":
    privileges => 'ALL',
    table      => 'nova.*',
    require    => Mysql_user["hyperscale@localhost"],
    user       => "hyperscale@localhost",
  }

  mysql_grant { "hyperscale@localhost/cinder.*":
    privileges => 'ALL',
    table      => 'cinder.*',
    require    => Mysql_user["hyperscale@localhost"],
    user       => "hyperscale@localhost",
  }

  mysql_grant { "hyperscale@%/nova.*":
    privileges => 'ALL',
    table      => 'nova.*',
    require    => Mysql_user["hyperscale@%"],
    user       => "hyperscale@%",
  }

  mysql_grant { "hyperscale@%/cinder.*":
    privileges => 'ALL',
    table      => 'cinder.*',
    require    => Mysql_user["hyperscale@%"],
    user       => "hyperscale@%",
  }

  if $mysql_vip != '' {
    mysql_grant { "hyperscale@$mysql_vip/nova.*":
      privileges => 'ALL',
      table      => 'nova.*',
      require    => Mysql_user["hyperscale@$mysql_vip"],
      user       => "hyperscale@$mysql_vip",
    }

    mysql_grant { "hyperscale@$mysql_vip/cinder.*":
      privileges => 'ALL',
      table      => 'cinder.*',
      require    => Mysql_user["hyperscale@$mysql_vip"],
      user       => "hyperscale@$mysql_vip",
    }
  }

  if $mysql_bind_host != '' {
    mysql_grant { "hyperscale@$mysql_bind_host/nova.*":
      privileges => 'ALL',
      table      => 'nova.*',
      require    => Mysql_user["hyperscale@$mysql_bind_host"],
      user       => "hyperscale@$mysql_bind_host",
    }

    mysql_grant { "hyperscale@$mysql_bind_host/cinder.*":
      privileges => 'ALL',
      table      => 'cinder.*',
      require    => Mysql_user["hyperscale@$mysql_bind_host"],
      user       => "hyperscale@$mysql_bind_host",
    }
  }

#  class {'veritas_hyperscale::db::schema' :
#    user     => $user,
#    password => $password,
#    dbname   => $dbname,
#  }
}
