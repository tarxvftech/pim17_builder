#!/sbin/openrc-run
# shellcheck shell=ash

# shellcheck disable=SC2034
description="Pulls in wpa_supplicant stanzas from /boot FAT partition to allow windows users to easily add their wifi networks"

depend()
{
	need dev localmount
	before wpa_supplicant
	keyword -docker -lxc -openvz -prefix -systemd-nspawn -uml -vserver -xenu
	#make this a no-op in the above environments as it probably doesn't make sense to do wifi in them
}

start()
{
	ebegin "Appending wifi settings from /boot/wpa_supplicant_additions.txt to wpa supplicant configuration"
	cat /data/etc/wpa_supplicant/wpa_supplicant.confbase /boot/wpa_supplicant_additions.txt > /data/etc/wpa_supplicant/wpa_supplicant.conf 
	eend 0
}
