# == Class: rabbitmq_exchanges
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class  veritas_hyperscale::rabbitmq_exchanges (
) inherits veritas_hyperscale
{
  require veritas_hyperscale::hs_rabbitmq
  require veritas_hyperscale::rabbitmq_management

  $rabbit_pass = hiera('vrts_rabbitmq_pass', '')
  if $rabbit_pass == '' {
    $password = 'elacsrepyh'
  } else {
    $password = $rabbit_pass
  }

  rabbitmq_exchange { 'hyperscale-controller@/':
    user     => 'hyperscale',
    password => $password,
    type     => 'direct',
    durable  => true,
  }

  rabbitmq_exchange { 'hyperscale-stats@/':
    user     => 'hyperscale',
    password => $password,
    type     => 'direct',
    durable  => true,
  }

  rabbitmq_exchange { 'hyperscale-datanode@/':
    user     => 'hyperscale',
    password => $password,
    type     => 'direct',
    durable  => true,
  }

  rabbitmq_exchange { 'hyperscale-recv@/':
    user     => 'hyperscale',
    password => $password,
    type     => 'direct',
    durable  => true,
  }

  rabbitmq_exchange { 'hyperscale-storage@/':
    user     => 'hyperscale',
    password => $password,
    type     => 'direct',
    durable  => true,
  }

  rabbitmq_exchange { 'hyperscale-compute-hy@/':
    user     => 'hyperscale',
    password => $password,
    type     => 'direct',
    durable  => true,
  }

  rabbitmq_exchange { 'hyperscale-datanode-hypervisor@/':
    user     => 'hyperscale',
    password => $password,
    type     => 'direct',
    durable  => true,
  }
}
