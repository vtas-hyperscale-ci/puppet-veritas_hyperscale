# == Class: hs_keystone
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
#
# Copyright (c) 2017 Veritas Technologies LLC.
#
class  veritas_hyperscale::hs_keystone (
) inherits veritas_hyperscale
{
  require veritas_hyperscale

  include ::keystone::deps

  $keystone_ip = hiera('keystone_admin_api_vip', false)

  $keystone_pass = hiera('keystone::admin_password', '')
  if $keystone_pass == '' {
    $password = 'elacsrepyh'
  } else {
    $password = $keystone_pass
  }

  if ($keystone_ip) {
    keystone_user { 'hyperscale':
      ensure   => present,
      enabled  => true,
      email    => 'hyperscale@localhost',
      password => $password,
    }

    keystone_user_role { 'hyperscale@service':
      ensure => present,
      roles  => ['admin'],
    }

    keystone_role { 'infra_admin':
      ensure => present,
    }

#   Changing admin user characteristics is not working.
#    keystone_user_role { 'admin@admin':
#      #ensure => present,
#      roles  => ['infra_admin'],
#    }
#
#require => Class['::keystone::roles::admin']

    keystone_service { 'hyperscale':
      ensure      => present,
      name        => 'hyperscale',
      description => 'HyperScale Infrastructure Service',
      type        => 'infrastructure',
    }

    keystone_endpoint { 'hyperscale':
      ensure       => present,
      type         => 'infrastructure',
      region       => 'regionOne',
      public_url   => "http://$keystone_ip:8753/v1/%(tenant_id)s",
      admin_url    => "http://$keystone_ip:8753/v1/%(tenant_id)s",
      internal_url => "http://$keystone_ip:8753/v1/%(tenant_id)s",
    }
  }
}
