# == Class: filezilla
#
# Install Filezilla
#
# === Parameters:
#
# [*version*] Version of Filezilla to be installed
# [*mirror*] The sourceforge mirror Filezilla will be downloaded from
#
# === Examples
#
#  class { filezilla: }
#
# === Authors
#
# Ryan Skoblenick <ryan@skoblenick.com>
#
# === Copyright
#
# Copyright 2013 Ryan Skoblenick.
#
class filezilla (
  $mirror = $filezilla::params::mirror,
  $version = $filezilla::params::version
) inherits filezilla::params {
  anchor {'filezilla::begin': } ->
  class {'filezilla::install': } ->
  anchor {'filezilla::end': }
}