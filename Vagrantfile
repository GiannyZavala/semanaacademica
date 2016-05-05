VAGRANTFILE_API_VERSION = "2"
PROJECT_NAME = 'damdiram'
DEST_FOLDER = '/var/www/app'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'ubuntu/trusty64'
  config.vm.hostname = PROJECT_NAME
  config.vm.network 'private_network', ip: '192.168.123.90'

  if defined? VagrantPlugins::HostsUpdater
    config.hostsupdater.aliases = ["#{config.vm.hostname}.local", "www.#{config.vm.hostname}.local", "subdomain.#{config.vm.hostname}.local"]
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end

  config.vm.synced_folder 'www', DEST_FOLDER
  config.vm.provision 'shell', inline: 'test -d /etc/puppet/modules/apt || puppet module install puppetlabs/apt'
  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file  = 'site.pp'
    puppet.module_path    = 'puppet/modules'
    puppet.options        = '--verbose --debug'
    puppet.facter         = {
      'mysql_root_password'  => 'vagrant',
      'wwwroot'              => DEST_FOLDER,
      'db_username'          => 'username',
      'db_password'          => 'password',
      'db_name'              => 'database_name',
      'wp_url'               => "#{config.vm.hostname}.local",
      'wp_title'             => PROJECT_NAME,
      'wp_user'              => 'username',
      'wp_password'          => 'password',
      'wp_email'             => 'email@example.com',
      'username'             => 'vagrant',
      'group'                => 'www-data',
    }
  end

end
