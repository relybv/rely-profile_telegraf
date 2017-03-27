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
    inputs   => {
        'cpu' => {
            'percpu'   => true,
            'totalcpu' => true,
        },
    },
  }

  telegraf::input { 'internal':
    plugin_type => 'internal',
    options     => {
      'collect_memstats' => true,
    },
  }
  telegraf::input { 'disk':
    plugin_type => 'disk',
    options     => {
      'ignore_fs' => ['tmpfs', 'devtmpfs'],
    },
  }
  telegraf::input { 'diskio':
    plugin_type => 'diskio',
  }
  telegraf::input { 'kernel':
    plugin_type => 'kernel',
  }
  telegraf::input { 'mem':
    plugin_type => 'mem',
  }
  telegraf::input { 'processes':
    plugin_type => 'processes',
  }
  telegraf::input { 'swap':
    plugin_type => 'swap',
  }
  telegraf::input { 'system':
    plugin_type => 'system',
  }
  telegraf::input { 'net':
    plugin_type => 'net',
  }
  telegraf::input { 'netstat':
    plugin_type => 'netstat',
  }
}
