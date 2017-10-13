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

  service { 'rabbitmq-server':
    ensure => running,
    enable => true,
  }

  include veritas_hyperscale::rabbitmq_management
}
