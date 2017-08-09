# == Class: compute_pkg_inst
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#

# NOTE: This is place holder class and not used currently.

class veritas_hyperscale::compute_pkg_inst (
)inherits veritas_hyperscale
{
  require veritas_hyperscale

  file { '/tmp/install_pkgs':
    ensure  => 'present',
    content => 'test',
    path    => '/tmp/install_pkgs',
  }

  $path = "/tmp/veritas_hyperscale"
  $op = "latest"

  package { 'VRTSofcore':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofcore*",
  }

  package { 'VRTSofcn':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofcn*",
    require  => Package["VRTSofcore"],
  }

  package { 'VRTSofspt':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofspt*",
  }

  package { 'VRTSperl':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSperl*",
  }

  package { 'VRTSvlic':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSvlic*",
  }

  package { 'VRTSveki':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSveki*",
  }

  package { 'VRTSvxvm':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSvxvm*",
  }

  package { 'VRTSaslapm':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSaslapm*",
  }

 include veritas_hyperscale::compute_service_start

}
