# == Class: config_dumper
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#

class veritas_hyperscale::config_dumper (
)inherits veritas_hyperscale
{
  $ctrl_ip = hiera('vrts_ctrl_mgmt_ip', '')
  if $ctrl_ip == '' {
    fail("vrts_ctrl_mgmt_ip not set.")
  }

  $admin_passwd = hiera('keystone::admin_password', '')
  if $admin_passwd == '' {
    fail("admin_password not set.")
  }

  $glance_ip = hiera('glance_api_vip', '')
  if $glance_ip == '' {
    fail("glance_vip not set.")
  }

  $ks_ip = hiera('keystone_admin_api_vip', '')
  if $ks_ip == '' {
    fail("keystone_vip not set.")
  }

  $rabbit_ip = hiera('vrts_ctrl_mgmt_ip', '')
  if $rabbit_ip == '' {
    fail("rabbit_vip not set.")
  }

  $mysql_ip = hiera('mysql_vip', '')
  if $mysql_ip == '' {
    fail("mysql_vip not set.")
  }

  $rabbit_port = hiera('rabbitmq::port', '')
  if $rabbit_port == '' {
    fail("Rabbitmq port not set.")
  }

  $mysql_passwd = hiera('vrts_mysql_passwd', '')
  if $mysql_passwd == '' {
    $mysql_hyperscale_password = 'elacsrepyh'
  } else {
    $mysql_hyperscale_password = $mysql_passwd
  }

  $auth_url = hiera('nova::keystone::authtoken::auth_url', '')
  if $auth_url == '' {
    fail("Keystone auth url for nova is not set.")
  }

  $telemetry = hiera('VrtsConfigParam1', '')
  if $telemetry == '' {
    $telemetry_state = 'n'
  } else {
    $telemetry_state = $telemetry
  }

  exec { 'ofdb':
    before  => Exec['dump_conf'],
    path    => '/usr/bin:/usr/sbin:/bin',
    command => 'touch /var/opt/VRTSofcore/ofdb',
    creates => "/var/tmp/vrts/.hs_openstack_dump",
  }

  exec {'dump_conf':
    path        => '/usr/bin:/usr/sbin:/bin',
    environment => ["_ZK_IP=$ctrl_ip"],
    creates     => "/var/tmp/vrts/.hs_openstack_dump",
    command     => "/opt/VRTSofcore/bin/ofexec --operation controller_conf_tripleo --run --params \"controller_ip=$ctrl_ip;mgmt_ip=$ctrl_ip;mysql_host=$mysql_ip;glance_host=$glance_ip;rabbit_host=$rabbit_ip;keystone_host=$ks_ip;openstack_passwd=$admin_passwd;mysql_user=hyperscale;mysql_hyperscale_password=$mysql_passwd;mysql_db=HyperScale;auth_url=$auth_url;telemetry_state=$telemetry_state\"",
  } -> file {"/var/tmp/vrts/.hs_openstack_dump":
    ensure => 'present',
    path   => "/var/tmp/vrts/.hs_openstack_dump",
    owner  => 'heat-admin',
    group  => 'heat-admin',
    mode   => '644',
  }
}
