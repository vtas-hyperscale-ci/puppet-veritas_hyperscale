# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class compute_service_start {
	service { 'hyperscale-mq-hypervisor':
		ensure => running,
		enable => true,
		}

	service { 'hyperscale-mq-storage':
		ensure => running,
		enable => true,
		}

	service { 'hyperscale-ceilometer':
		ensure => running,
		enable => true,
		}
}
