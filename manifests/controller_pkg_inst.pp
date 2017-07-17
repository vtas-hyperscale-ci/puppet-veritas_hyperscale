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

  file { '/tmp/install_pkgs':
    ensure  => 'present',
    content => 'test',
    path    => '/tmp/install_pkgs',
  }

  $path = "/tmp/veritas_hyperscale"
  $op = "installed"

  package { 'VRTSofcore':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofcore-1.1.0.000-RHEL7.x86_64.rpm",
  }

  package { 'VRTSofmn':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofmn-1.1.0.000-RHEL7.x86_64.rpm",
    require  => Package["VRTSofcore"],
  }

  package { 'VRTSofspt':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofspt_1.0.0.100-RHEL7.x86_64.rpm",
  }

  if $step >=4 {
    include veritas_hyperscale::controller_service_start
  }
}
