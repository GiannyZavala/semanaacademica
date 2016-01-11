class wp-cli {

  exec { 'composer-wp-cli':
    path => '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/',
    command => 'sudo composer create-project wp-cli/wp-cli /usr/share/wp-cli --no-dev',
    unless => 'ls /usr/share/wp-cli'
  }

  file { '/usr/bin/wp':
    ensure => 'link',
    target => '/usr/share/wp-cli/bin/wp',
  }

  exec { 'wp-cli-fix-permissions':
    command => "chmod a+x /usr/share/wp-cli/bin/wp",
    path => '/usr/bin:/bin:/usr/sbin:/sbin',
    user => 'root',
  }

}
