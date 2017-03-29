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
  notify {"Running with ${profile_telegraf::monitor_address} ":}

  class { '::telegraf':
    hostname => $::fqdn,
    outputs  => {
        'influxdb' => {
            'urls'     => [ "http://${profile_telegraf::monitor_address}:8086" ],
            'database' => 'telegraf',
            'username' => 'admin',
            'password' => 'admin',
            },
        },
  }
}
