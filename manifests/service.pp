#
class ntp::service inherits ntp {

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    $use_servers = join($servers, " ")
    exec {"/usr/sbin/ntpdate -s -u ${use_servers}":} ->
    service { 'ntp':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
