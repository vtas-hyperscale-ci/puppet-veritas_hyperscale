# == Class: controller_save_conf
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#

class veritas_hyperscale::controller_save_conf (
)inherits veritas_hyperscale
{
  require veritas_hyperscale::db::mysql

  include veritas_hyperscale::rabbitmq_save_conf
  include veritas_hyperscale::config_dumper
}
