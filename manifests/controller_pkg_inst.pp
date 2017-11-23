# == Class: controller_pkg_inst
#
# === Parameters
#
# [*step*]
#   The current step in deployment. See tripleo-heat-templates
#   for more details.
#   Defaults to hiera('step')
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#

class veritas_hyperscale::controller_pkg_inst (
  $step = Integer(hiera('step')),
)inherits veritas_hyperscale
{
  require veritas_hyperscale

  $op = "latest"
  $pkg_path = "/etc/puppet/modules/veritas_hyperscale_packages/files"

  package { 'VRTSofcore':
    ensure   => $op,
    provider => 'rpm',
    source   => "${pkg_path}/VRTSofcore*",
  } ->

  package { 'VRTSofmn':
    ensure   => $op,
    provider => 'rpm',
    require  => Package["VRTSofcore"],
    source   => "${pkg_path}/VRTSofmn*",
  } ->

  file {"/var/tmp/vrts/.hs_pkgs":
    ensure  => 'present',
    path    => "/var/tmp/vrts/.hs_pkgs",
    owner   => 'heat-admin',
    group   => 'heat-admin',
    mode    => '644',
  }

  if $step >=4 {
    include veritas_hyperscale::controller_save_conf
  }
}
