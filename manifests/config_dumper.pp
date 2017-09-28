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
  $cmd = "/opt/VRTSofcore/lib/modules/ofconfigdumper.py"

  exec {'dump_conf':
    path   => '/usr/bin:/usr/sbin:/bin',
    command => "python $cmd",
  }
}
