# == Class: profile_telegraf
#
# Full description of class profile_telegraf here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_telegraf
(
  $monitor_address = $::profile_telegraf::params::monitor_address,
) inherits ::profile_telegraf::params {

  if $monitor_address != undef {
    validate_string($monitor_address)
  }
  class { '::profile_telegraf::install': } ->
  class { '::profile_telegraf::config': } ~>
  class { '::profile_telegraf::service': } ->
  Class['::profile_telegraf']
}
