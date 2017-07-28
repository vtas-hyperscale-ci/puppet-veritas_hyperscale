# == Class: hs_rabbitmq
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class  veritas_hyperscale::hs_rabbitmq (
) inherits veritas_hyperscale
{
  require veritas_hyperscale

  $rabbit_pass = hiera('vrts_rabbitmq_pass', '')
  if $rabbit_pass == '' {
    $password = 'elacsrepyh'
  } else {
    $password = $rabbit_pass
  }

# === Ocata
  rabbitmq_user { 'hyperscale':
    admin    => true,
    password => $password,
    provider => 'rabbitmqctl',
  }

  rabbitmq_user_permissions { "hyperscale@/":
    configure_permission => '.*',
    write_permission     => '.*',
    read_permission      => '.*',
    provider             => 'rabbitmqctl',
  }
  rabbitmq_vhost { '/':
    provider => 'rabbitmqctl',
  }

# === Master
#  ::openstacklib::messaging::rabbitmq {'vrts_hyperscale':
#    userid   => 'hyperscale',
#    password => $password,
#    configure_permission => '.*',
#    write_permission     => '.*',
#    read_permission      => '.*',
#  }
#  rabbitmq_user_permissions { 'hyperscale@/':
#    configure_permission => '.*',
#    write_permission     => '.*',
#    read_permission      => '.*',
#    provider             => 'rabbitmqctl',
#  }
#  rabbitmq_vhost { '/':
#   provider => 'rabbitmqctl',
#  }

  # FIXME The rabbitmq_exchange also uses rabiitmqadmin
  # script just like hs_rabbitmq.sh
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
