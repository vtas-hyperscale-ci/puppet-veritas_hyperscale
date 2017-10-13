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
  file {"/var/tmp/vrts":
    ensure => 'directory',
    owner  => 'heat-admin',
    group  => 'heat-admin',
    mode   => '644',
  }
}
