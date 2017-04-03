# == Class profile_telegraf::config
#
# This class is called from profile_telegraf for service config.
#
class profile_telegraf::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  if $::osfamily == 'Windows' {
    file { 'C:\Program Files\telegraf\telegraf.d\inputs.conf':
      source => template('profile_telegraf/telegraf.inputs.conf.erb'),
    }
  } else {
  # telegraf dynamic plugins
  if defined('haproxy') {
    telegraf::input { 'haproxy':
      plugin_type => 'haproxy',
        options   => {
      'servers' => ['socket:/var/lib/haproxy/stats'],
    },
    }
  }
  if defined('mysql::server') {
    telegraf::input { 'mysql':
      plugin_type => 'mysql',
        options   => {
      'servers' => ['telegraf:telegraf@/'],
    },
    }
  }
  if defined('apache::mod::status') {
    telegraf::input { 'apache':
      plugin_type => 'apache',
    }
  }

  # standard telegraf plugins
  telegraf::input { 'cpu':
    plugin_type => 'cpu',
        options => {
      'percpu'   => true,
      'totalcpu' => true,
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
}
