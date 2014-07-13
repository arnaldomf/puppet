node default {
  notify {"I'm notifying you.":}
#  package {'varnish':
#    ensure => installed,
#  }
}

node /varnish\d+/ {
  include varnish
}

node /purger.*/ {
#  package {'ruby2.0':
#    ensure => installed,
#  }
  package {'ruby1.9.1-dev':
   ensure => installed,
  }
  package {'build-essential':
   ensure => installed,
  }
  package {'libsasl2-dev':
   ensure => installed,
  }
}

node /master/ {
  class {'puppetdb': }
  class {'puppetdb::master::config': }
}
