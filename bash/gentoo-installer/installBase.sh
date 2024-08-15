editor=nano
region=America

emerge-webrsync
emerge --oneshot app-portage/mirrorselect
mirrorselect -io >> /etc/portage/make.conf
emerge --oneshot app-portage/cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags

ls -l /usr/share/zoneinfo/$region
read -sp "City: " city
echo "$region/$city" /etc/timezone
emerge --config sys-libs/timezone-data

$editor /etc/locale.gen
locale-gen
eselect locale list
read -sp "Locale: " locale
eselect locale set $locale
env-update && . /etc/profile
