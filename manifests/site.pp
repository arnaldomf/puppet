node default {
  notify {"I'm notifying you.":}
#  package {'varnish':
#    ensure => installed,
#  }
}

node /varnish\d+/ {
  include varnish
}

node /master/ {
  class {'puppetdb': }
  class {'puppetdb::master::config': }
}
