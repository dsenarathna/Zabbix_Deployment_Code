# Class: zabbix
#
# This class installs and manages zabbix agents
#
# Parameters:
#
# Actions:
#   - Install zabbix agent
#   - Manage zabbix agent service
#
# Requires:
#
# Sample Usage:
#
class zabbix (
  $zabbix_server = $zabbix::params::server,
) inherits zabbix::params {
  package {
    'zabbix-agent':
      ensure => latest;
  }

  service {
    'zabbix-agent':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['zabbix-agent'];
  }

  file {
    '/etc/zabbix':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755';
    '/etc/zabbix/scripts':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      recurse => remote,
      source  => 'puppet:///puppet_dir_master/systems/_LINUX_/etc/zabbix/scripts';
     '/etc/zabbix/zabbix_agentd.d':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      recurse => remote,
      source  => 'puppet:///puppet_dir_master/systems/_LINUX_/etc/zabbix/zabbix_agentd.d';
    '/etc/zabbix/zabbix_agentd.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${::puppet_dir_master}/systems/_LINUX_/etc/zabbix/zabbix_agentd.conf"),
      notify  => Service['zabbix-agent'];
  }
}
