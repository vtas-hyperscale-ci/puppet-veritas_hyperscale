# == Class: datanode_pkg_inst
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.


# NOTE: This is place holder class and not used currently.

class veritas_hyperscale::datanode_pkg_inst (
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

  package { 'VRTSofdn':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofdn*",
    require  => Package["VRTSofcore"],
  }

  package { 'VRTSofmn':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofmn*",
    require  => Package["VRTSofcore"],

  package { 'VRTSofspt':
    ensure   => $op,
    provider => 'rpm',
    source   => "${path}/packages/VRTSofspt*",
  }

  package { 'python-amqp':
    ensure   => $op,
    provider => 'yum',
  }

  package { 'python-kombu':
    ensure   => $op,
    provider => 'yum',
  }

  package { 'python-kazoo':
    ensure   => $op,
    provider => 'yum',
  }

  package { 'python-anyjson':
    ensure   => $op,
    provider => 'yum',
  }

  package { 'python-sqlalchemy':
    ensure   => $op,
    provider => 'yum',
  }

  package { 'lvm2':
    ensure   => $op,
    provider => 'yum',
  }

  package { 'coreutils':
    ensure   => $op,
    provider => 'yum',
  }

 include veritas_hyperscale::datanode_service_start

}
