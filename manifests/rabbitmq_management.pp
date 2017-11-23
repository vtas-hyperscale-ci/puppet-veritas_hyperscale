# == Class: rabbitmq_management
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class  veritas_hyperscale::rabbitmq_management (
) inherits veritas_hyperscale
{
  require veritas_hyperscale::hs_rabbitmq

  $passwd = hiera('vrts_rabbitmq_passwd', '')

  if $passwd == '' {
    $password = 'elacsrepyh'
  } else {
    $password = $passwd
  }

  exec {'exchanges':
    path    => '/usr/bin:/usr/sbin:/bin',
    command => "sh /etc/puppet/modules/veritas_hyperscale/files/scripts/hs_rabbitmq.sh $password",
  }
}
