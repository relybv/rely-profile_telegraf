# == Class profile_telegraf::install
#
# This class is called from profile_telegraf for install.
#
class profile_telegraf::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  if $profile_telegraf::monitor_address == undef {
    $monitor_address = localhost
  } else {
    $monitor_address = $profile_telegraf::monitor_address
  }

  Class['apt::update'] -> Package['telegraf']

  $_operatingsystem = downcase($::operatingsystem)

  if ! defined(Apt::Source['influxrepo']) {
    ensure_resource('apt::source', 'influxrepo', {'ensure' => 'present', 'location' => "https://repos.influxdata.com/${_operatingsystem}", 'release' => $::lsbdistcodename, 'repos' => 'stable', 'key' => { 'id' => '05CE15085FC09D18E99EFB22684A14CF2582E0C5', 'source' => 'https://repos.influxdata.com/influxdb.key',} })
  }

  class { '::telegraf':
    manage_repo => false,
    outputs     => {
        'influxdb' => {
            'urls'     => [ "http://${profile_telegraf::monitor_address}:8086" ],
            'database' => 'telegraf',
            'username' => 'admin',
            'password' => 'admin',
            },
        },
    require     => Apt::Source['influxrepo'],
  }
}
