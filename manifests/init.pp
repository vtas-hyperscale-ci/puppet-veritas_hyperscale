# == Class: hyperscale
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class  veritas_hyperscale (
)
{
  $path = '/tmp/veritas_hyperscale'

  # Bin file
  file {"$path":
    ensure  => 'directory',
    source  => "puppet:///modules/veritas_hyperscale",
    path    => "${path}",
    recurse => 'remote',
    owner   => 'heat-admin',
    group   => 'heat-admin',
    mode    => '744',
  }
}
