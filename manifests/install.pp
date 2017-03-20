# == Class profile_telegraf::install
#
# This class is called from profile_telegraf for install.
#
class profile_telegraf::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { '::telegraf':
    hostname => $::hostname,
    outputs  => {
        'influxdb' => {
            'urls'     => [ 'http://localhost:8086' ],
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
}
