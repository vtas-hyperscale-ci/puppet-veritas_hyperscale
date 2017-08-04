# == Class: vrts_hs_repo
#
# === Author
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
# Copyright (c) 2017 Veritas Technologies LLC.
#

class veritas_hyperscale::vrts_hs_repo () inherits veritas_hyperscale
{
  $base_dir = "/etc/puppet/modules/veritas_hyperscale/files"
  $repo_dir = "${base_dir}/repo"
  $pkg_dir = "${base_dir}/packages"

  file { "${repo_dir}":
    ensure => 'link',
    target => "${pkg_dir}",
  }

  exec { 'create_hyperscale_repo':
    command => "/usr/bin/createrepo ${repo_dir}",
  }

  yumrepo { 'HyperScale':
    enabled  => 1,
    descr    => 'Local repo holding Veritas HyperScale packages',
    baseurl  => "file://${repo_dir}",
    gpgcheck => 0,
  }
}
