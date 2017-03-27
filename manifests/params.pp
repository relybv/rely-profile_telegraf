# == Class profile_telegraf::params
#
# This class is meant to be called from profile_telegraf.
# It sets variables according to platform.
#
class profile_telegraf::params {
  $monitor_address = $::monitor_address
  case $::osfamily {
    'Debian': {
      $package_name = 'profile_telegraf'
      $service_name = 'profile_telegraf'
    }
    'RedHat', 'Amazon': {
      $package_name = 'profile_telegraf'
      $service_name = 'profile_telegraf'
    }
    'Windows': {
      $package_name = 'profile_telegraf'
      $service_name = 'profile_telegraf'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
