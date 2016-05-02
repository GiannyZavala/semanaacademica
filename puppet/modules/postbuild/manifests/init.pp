class postbuild {
  $wp_bin = "/usr/bin/wp --allow-root"
  exec { 'wp-download':
    command => "$wp_bin core download",
    cwd => $::wwwroot,
    unless => '/bin/ls wp-content',
  }

  $content = "
CREATE DATABASE $::db_name;
CREATE USER $::db_username@localhost;
GRANT ALL PRIVILEGES ON *.* TO '$::db_username'@'localhost' IDENTIFIED BY '$::db_password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"
  exec { 'mysql-configuration':
    path   => "/usr/bin:/usr/sbin:/bin",
    command => "mysql -u root -p$::mysql_root_password -e \"$content\"",
    unless => "/usr/bin/mysql -u root -p$::mysql_root_password -e 'show databases' | grep $::db_name",
  }

  exec { 'wp-configuration':
    command => "$wp_bin core --path=$wp_path config --dbname=$::db_name --dbuser=$::db_username --dbpass=$::db_password",
    require => Exec['mysql-configuration'],
    unless => "/bin/ls wp-config.php",
    cwd => $::wwwroot,
  }

  exec { 'wp-installation':
    command => "$wp_bin core install --url=$::wp_url --title=$::wp_title --admin_user=$::wp_user --admin_password=$wp_password --admin_email=$wp_email --skip-email",
    require => Exec['wp-configuration'],
    cwd => $::wwwroot,
    unless => "$wp_bin core is-installed"
  }
}
