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

  file {"/tmp/.hs_pkgs":
    ensure  => 'present',
    path    => "/tmp/.hs_pkgs",
    owner   => 'heat-admin',
    group   => 'heat-admin',
    mode    => '644',
  }

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
    source   => "${pkg_path}/VRTSofmn*",
    require  => Package["VRTSofcore"],
  } ->

  package { 'VRTSofspt':
    ensure   => $op,
    provider => 'rpm',
    source   => "${pkg_path}/VRTSofspt*",
  }

  if $step >=4 {
    include veritas_hyperscale::controller_save_conf
    #include veritas_hyperscale::controller_service_start
  }
}
