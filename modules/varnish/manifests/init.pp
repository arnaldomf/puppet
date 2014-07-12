class varnish {
  package {'varnish':
    ensure => installed,
  }
  file {'/etc/default/varnish':
    ensure => file,
    mode   => 0644,
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/varnish/default",
    require => Package['varnish'],
  }
  file {'/etc/varnish/default.vcl':
    ensure => file,
    mode   => 0644,
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/varnish/default.vcl",
    require => Package['varnish'],
    notify => Service['varnish']
  }
  service {'varnish':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus  => true,
#    subscribe  => File['/etc/varnish/default.vcl'],
    require => Package['varnish'],
  }
}
