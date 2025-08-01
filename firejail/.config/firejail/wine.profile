# Firejail profile for wine
# Description: A compatibility layer for running Windows programs
# This file is overwritten after every install/update
# Persistent local customizations
include wine.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.cache/wine
noblacklist ${HOME}/.cache/winetricks
noblacklist ${HOME}/.Steam
noblacklist ${HOME}/.local/share/Steam
noblacklist ${HOME}/.local/share/steam
noblacklist ${HOME}/.steam
noblacklist ${HOME}/.wine
noblacklist /tmp/.wine-*
noblacklist ${HOME}/.local/share/lutris
noblacklist /media/disk2/gaming/
noblacklist ${HOME}/Games/Wine

# Allow python (blacklisted by disable-interpreters.inc)
include allow-python2.inc
include allow-python3.inc

include disable-common.inc
include disable-devel.inc
include disable-interpreters.inc
include disable-programs.inc

#whitelist /usr/share/wine
#include whitelist-usr-share-common.inc
include whitelist-var-common.inc

# Some applications don't need allow-debuggers. Add 'ignore allow-debuggers' to your wine.local if you want to override this.
allow-debuggers
keep-dev-ntsync

caps.drop all
#net none
netfilter
nodvd
nogroups
noinput
nonewprivs
noroot
#nosound
notv
#novideo
private-dev
restrict-namespaces
blacklist /mnt
blacklist /media/disk1
blacklist /media/disk3
