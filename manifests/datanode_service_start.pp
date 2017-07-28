# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#
class datanode_service_start {
	service { 'hyperscale-mq-dnhypervisor':
		ensure => running,
		enable => true,
		}

	service { 'hyperscale-dmld':
		ensure => running,
		enable => true,
		}

	service { 'hyperscale-bud':
		ensure => running,
		enable => true,
		}
}
