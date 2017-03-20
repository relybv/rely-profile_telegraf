# == Class profile_telegraf::config
#
# This class is called from profile_telegraf for service config.
#
class profile_telegraf::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
