# (c) 2014 Sam Nazarko
# email@samnazarko.co.uk

#!/bin/bash

function check_platform()
{
platform=$(lsb_release -a | grep Debian)
echo $platform | grep -q wheezy
if [ $? != 0 ]; then echo -e "We are not running Debian Wheezy" && return 1; else return 0; fi
}

function verify_action()
{
	if [ $? != 0 ]; then echo -e "Exiting build" && exit 1; fi
}

function enable_nw_chroot()
{
	echo -e "Enabling networking"
	cp /etc/resolv.conf $1/etc/
	if [ $? != 0 ]; then echo -e "Can't copy networking file" && return 1; fi
	cp /etc/network/interfaces $1/etc/network
	if [ $? != 0 ]; then echo -e "Can't copy networking file" && return 1; fi
}

function add_apt_key()
{
	echo -e "Adding apt key"
	chroot ${1} wget http://apt.osmc.tv/apt.key -O /tmp/key
	chroot ${1} apt-key add /tmp/key
	rm ${1}/tmp/key > /dev/null 2>&1
}

export -f check_platform
export -f verify_action
export -f enable_nw_chroot
export -f add_apt_key
