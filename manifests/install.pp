# == Class: filezilla::install
#
# Install Filezilla
#
# === Authors
#
# Ryan Skoblenick <ryan@skoblenick.com>
#
# === Copyright
#
# Copyright 2013 Ryan Skoblenick.
#
class filezilla::install {
  $mirror = $filezilla::mirror
  $version = $filezilla::version

  $source = $::osfamily ? {
    'Darwin' => "http://${mirror}.dl.sourceforge.net/project/filezilla/FileZilla_Client/${version}/FileZilla_${version}_i686-apple-darwin9.app.tar.bz2",
  }

  Exec {
    cwd => '/tmp',
    path => $::path,
    onlyif => "test ! -f /var/db/.puppet_app_installed_filezilla-${version}",
  }

  exec {'filezilla-download':
    command => "curl -o filezilla.tar.bz2 -k -L -s --fail --url ${source}",
  }
  ->
  exec {'filezilla-install':
    command => 'tar -xzvf filezilla.tar.bz2 -C /Applications',
    user => 'root',
  }
  ->
  file {'filezilla-cleanup':
    path => '/tmp/filezilla.tar.bz2',
    ensure => absent,
  }
  ->
  file {'filezilla-cookie':
    path => "/var/db/.puppet_app_installed_filezilla-${version}",
    ensure => file,
    content => "name:'filezilla'\nsource:'${source}'",
    owner => 'root',
    group => 'wheel',
    mode => '0644',
  }
}
