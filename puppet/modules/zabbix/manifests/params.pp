# Class: zabbix::params
#
# This class manages parameters for the zabbix module
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class zabbix::params {
  $server = $server ? {
    ''      => '127.0.0.1',
    default => $server
  }
}
