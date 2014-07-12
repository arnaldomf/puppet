node default {
  notify {"I'm notifying you.":}
}

node /master/ {
  class {'puppetdb': }
  class {'puppetdb::master::config': }
}
