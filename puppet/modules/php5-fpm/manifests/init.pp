class php5-fpm {
  include apt

  apt::key { 'ppa:ondrej/php5-5.6':
    ensure => present,
    server => 'hkp://keyserver.ubuntu.com:80',
    id     => 'E5267A6C',
  }

  apt::ppa { 'ppa:ondrej/php5-5.6':
    require => Apt::Key['ppa:ondrej/php5-5.6'],
  }

  package { ['php5-fpm', 'php5-cli']:
    ensure  => installed,
    require => Apt::Ppa['ppa:ondrej/php5-5.6'],
  }

  exec { 'deleting-bad-characters':
    command => "/bin/sed -i '/author/d' /etc/init/php5-fpm.conf",
    before => Service['php5-fpm'],
    require => Package['php5-fpm', 'php5-cli'],
  }

  service { 'php5-fpm':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['php5-fpm'],
  }

  file { '/etc/php5/fpm/pool.d/www.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    content  => template('php5-fpm/www.conf.erb'),
    notify  => Service['php5-fpm'],
    require => Package['php5-fpm'],
  }

  file { '/etc/php5/fpm/php.ini':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/php5-fpm/php.ini',
    notify  => Service['php5-fpm'],
    require => Package['php5-fpm'],
  }

  include mariadb::php5-mysql
}
