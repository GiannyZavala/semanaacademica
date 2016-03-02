exec { 'create-app-root':
  command => "/bin/mkdir -p $::wwwroot",
  before => Class['nginx', 'mariadb::install', 'php5-fpm', 'phpmyadmin', 'git::install'],
}

class { 'nginx': }
class { 'mariadb::install': }
class { 'php5-fpm': }
class { 'phpmyadmin':
  require => Class['mariadb::install'],
}
class { 'git::install': }
class { 'composer':
  command_name => 'composer',
  target_dir   => '/usr/local/bin',
  require => Class['php5-fpm'],
}
class { 'wp-cli':
  require => Class['composer'],
}

class { 'postbuild':
  require => Class['mariadb::install', 'wp-cli']
}
