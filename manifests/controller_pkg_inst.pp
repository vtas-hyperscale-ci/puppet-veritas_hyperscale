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
  require veritas_hyperscale::vrts_hs_repo

  file { '/tmp/install_pkgs':
    ensure  => 'present',
    content => 'test',
    path    => '/tmp/install_pkgs',
  }

  $op = "latest"

  package { 'VRTSofcore':
    ensure   => $op,
    require => Yumrepo['HyperScale'],
  }

  package { 'VRTSofmn':
    ensure   => $op,
    require  => [ Package["VRTSofcore"], Yumrepo['HyperScale']],
  }

  package { 'VRTSofspt':
    ensure   => $op,
    require => Yumrepo['HyperScale'],
  }

  if $step >=4 {
    include veritas_hyperscale::controller_service_start
  }
}
