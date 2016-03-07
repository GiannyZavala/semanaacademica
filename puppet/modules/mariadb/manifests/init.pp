class mariadb::install {
  package { 'MariaDB-server':
    ensure  => installed,
  }

  exec { 'set-mysql-root-password':
    path        => '/bin:/usr/bin',
    unless      => "mysqladmin -uroot -p${::mysql_root_password} status",
    refreshonly => true,
    command     => "mysqladmin -uroot password ${::mysql_root_password}",
    subscribe   => Package['MariaDB-server'],
  }
}

class mariadb::php5-mysql {
  package { 'php5-mysql':
    ensure  => installed,
    require => Package['php5-fpm', 'MariaDB-server'],
    notify  => Service['php5-fpm'],
  }
}
