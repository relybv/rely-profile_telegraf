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
{
  # commentaar
  class { '::profile_telegraf::install': } ->
  class { '::profile_telegraf::config': } ~>
  class { '::profile_telegraf::service': } ->
  Class['::profile_telegraf']
}
