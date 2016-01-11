class { 'nginx': }
class { 'mariadb::install': }
class { 'php5-fpm': }
class { 'phpmyadmin': }
class { 'git::install': }
class { 'composer':
  command_name => 'composer',
  target_dir   => '/usr/local/bin'
}
class { 'wp-cli': }
