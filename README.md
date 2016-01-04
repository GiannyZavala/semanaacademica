# Vagrant Trusty LEMP

This project contains a Vagrantfile and some Puppet scripts to set up a LEMP stack
for local development (as an alternative to MAMP, XAMPP, among other options).
It can be used for a variety of PHP projects, including WordPress, by adding files
to the **www** synced folder and configuring the VM via SSH.

This README details how to install Vagrant and lift a VM with it.

## Pre-requisites

* Install the latest version of [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads).
* Minimal system requirements:
  * RAM: 1GB (4GB, recommended).
  * Hard Disk: ~2.5GB (up to 40GB, set up as a VirtualBox expanding disk).

## Installation

* Download the latest version of [Vagrant](https://www.vagrantup.com/downloads.html).
* Mount the DMG image and open the PKG executable.
* Follow the installation steps until completion.
* Install the [Vagrant HostsUpdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin.
```bash
$ vagrant plugin install vagrant-hostsupdater
```

## Configuration

* Clone this repository in the desired location.
```bash
$ git clone https://github.com/wizeservices/vagrant-trusty-lemp [name-of-my-lemp-project]
```
* Open the Vagrantfile with your favorite text editor.
* Edit the **PROJECT_NAME** variable to suit your desired project name. This name will be used as vhost with the TLD **.local**.
* If your project requires subdomains, add them to the array property named **config.hostsupdater.aliases**.
* You can also modify MySQL's root password by editing the **mysql_root_password** property.

## Usage

* Lift the VM with `vagrant up`.
  * The first time you lift it, it might take a long time because
  it needs to download and set up the Ubuntu box and install
  the Puppet modules.
  * Your password will be required to alter your hosts file.
  * You can test your installation by creating an **index.php** inside the **www/** folder, then browsing `http://[PROJECT_NAME].local`.
* You can restart the VM with `vagrant reload` or stop it with `vagrant halt`.
* If you're not gonna need the VM anymore and want to free the resources you can use `vagrant destroy`.
