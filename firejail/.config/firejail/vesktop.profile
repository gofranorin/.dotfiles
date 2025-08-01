# Firejail profile for PROGRAM_NAME
# Description: DESCRIPTION OF THE PROGRAM
# This file is overwritten after every install/update
# --- CUT HERE ---
# This is a generic template to help you create profiles.
# PRs welcome at https://github.com/netblue30/firejail/.
#
# Rules to follow:
#  - lines with one # are often used in profiles
#  - lines with two ## are only needed in special situations
#  - make the profile as restrictive as possible while still keeping the program useful
#    (e.g. a program that is unable to save user's work is considered bad practice)
#  - dedicate ample time (based on the complexity of the application) to profile testing before
#    submitting a pull request
#  - keep the sections structure, use a single empty line as separator
#  - entries within sections are alphabetically sorted
#  - consider putting binary into src/firecfg/firecfg.config (keep list sorted) but beware
#    to not do this for essential utilities as this may *break* your OS! (related discussion:
#    https://github.com/netblue30/firejail/issues/2507)
#  - remove this comment section and any generic comment past 'Persistent global definitions'
#
# Sections structure
#   HEADER
#   COMMENTS
#   IGNORES
#   NOBLACKLISTS
#   ALLOW INCLUDES
#   BLACKLISTS
#   DISABLE INCLUDES
#   NOWHITELISTS
#   MKDIRS
#   WHITELISTS
#   WHITELIST INCLUDES
#   OPTIONS (caps*, net*, no*, protocol, seccomp*, tracelog)
#   PRIVATE OPTIONS (disable-mnt, private-*, writable-*)
#   DBUS FILTER
#   SPECIAL OPTIONS (mdwx, noexec, read-only, join-or-start)
#   REDIRECT INCLUDES
#
# The following macros may be used in path names to substitute common locations:
#  ${DESKTOP}
#  ${DOCUMENTS}
#  ${DOWNLOADS}
#  ${HOME} (user's home)
#  ${PATH} (contents of PATH env var)
#  ${MUSIC}
#  ${RUNUSER} (/run/user/UID)
#  ${VIDEOS}
#
# Check contents of ~/.config/user-dirs.dirs to see how they translate to actual paths.
#
# --- CUT HERE ---
##quiet
# Persistent local customizations
include vesktop.local
# Persistent global definitions
include globals.local

##ignore noexec ${HOME}
##ignore noexec /tmp

# It is common practice to add files/dirs containing program-specific configuration
# (often ${HOME}/PROGRAMNAME or ${HOME}/.config/PROGRAMNAME) into disable-programs.inc
# (keep list sorted) and then disable blacklisting below.
# One way to retrieve the files a program uses is:
#  - launch binary with --private naming a sandbox
#      `firejail --name=test --ignore=private-bin [--profile=PROFILE] --private BINARY`
#  - work with the program, make some configuration changes and save them, open new documents,
#    install plugins if they exists, etc.
#  - join the sandbox with bash:
#      `firejail --join=test bash`
#  - look what has changed and use that information to populate blacklist and whitelist sections
#      `ls -aR`
#noblacklist PATH

# Allow /bin/sh (blacklisted by disable-shell.inc)
#include allow-bin-sh.inc

# Allows files commonly used by IDEs
#include allow-common-devel.inc

# Allow gjs (blacklisted by disable-interpreters.inc)
#include allow-gjs.inc

# Allow java (blacklisted by disable-devel.inc)
#include allow-java.inc

# Allow lua (blacklisted by disable-interpreters.inc)
#include allow-lua.inc

# Allow nodejs (blacklisted by disable-interpreters.inc)
#include allow-nodejs.inc

# Allow opengl-game wrapper script (distribution-specific)
#include allow-opengl-game.inc

# Allow perl (blacklisted by disable-interpreters.inc)
#include allow-perl.inc

# Allow php (blacklisted by disable-interpreters.inc)
#include allow-php.inc

# Allow python (blacklisted by disable-interpreters.inc)
#include allow-python2.inc
#include allow-python3.inc

# Allow ruby (blacklisted by disable-interpreters.inc)
#include allow-ruby.inc

# Allow ssh (blacklisted by disable-common.inc)
#include allow-ssh.inc

##blacklist PATH
# Disable Wayland
#blacklist ${RUNUSER}/wayland-*
# Disable RUNUSER (cli only; supersedes Disable Wayland)
#blacklist ${RUNUSER}
# Remove the next blacklist if your system has no /usr/libexec dir,
# otherwise try to add it.
#blacklist /usr/libexec

# disable-*.inc includes
# remove disable-write-mnt.inc if you set disable-mnt
#include disable-common.inc
#include disable-devel.inc
#include disable-exec.inc
#include disable-interpreters.inc
#include disable-proc.inc
#include disable-programs.inc
#include disable-shell.inc
#include disable-write-mnt.inc
#include disable-x11.inc
#include disable-xdg.inc

# This section often mirrors noblacklist section above. The idea is
# that if a user feels too restricted (e.g. unable to save files into
# home directory) they may disable whitelist (nowhitelist)
# in PROFILE.local but still be protected by BLACKLISTS section
# (explanation at https://github.com/netblue30/firejail/issues/1569)
#mkdir PATH
##mkfile PATH
#whitelist PATH
#include whitelist-common.inc
#include whitelist-run-common.inc
#include whitelist-runuser-common.inc
#include whitelist-usr-share-common.inc
#include whitelist-var-common.inc

# Landlock commands
##landlock.fs.read PATH
##landlock.fs.write PATH
##landlock.fs.makeipc PATH
##landlock.fs.makedev PATH
##landlock.fs.execute PATH
#include landlock-common.inc

##allusers
#apparmor
#caps.drop all
##caps.keep CAPS
##hostname NAME
# CLI only
##ipc-namespace
# breaks audio and sometimes dbus related functions
#machine-id
# 'net none' or 'netfilter'
#net none
#netfilter
#no3d
##nodbus (deprecated, use 'dbus-user none' and 'dbus-system none', see below)
#nodvd
#nogroups
#noinput
#nonewprivs
#noprinters
#noroot
#nosound
#notpm
#notv
#nou2f
#novideo
# Remove each unneeded protocol:
#  - unix is usually needed
#  - inet,inet6 only if internet access is required (see 'net none'/'netfilter' above)
#  - netlink is rarely needed
#  - packet and bluetooth almost never
#protocol unix,inet,inet6,netlink,packet,bluetooth
#seccomp
##seccomp !chroot
##seccomp.drop SYSCALLS (see syscalls.txt)
#seccomp.block-secondary
##seccomp-error-action log (only for debugging seccomp issues)
#tracelog
# Prefer 'x11 none' instead of 'disable-x11.inc' if 'net none' is set
##x11 none

#disable-mnt
##keep-dev-ntsync
##private
# It's common practice to refer to the python executable(s) in private-bin with `python*`, which covers both v2 and v3
#private-bin PROGRAMS
#private-cache
#private-dev
#private-etc FILES
# private-etc templates (see also #1734, #2093)
#  Common: alternatives,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,locale,locale.alias,locale.conf,localtime,mime.types,xdg
#    Extra: group,magic,magic.mgc,passwd
#  3D: bumblebee,drirc,glvnd,nvidia
#  Audio: alsa,asound.conf,machine-id,pulse
#  D-Bus: dbus-1,machine-id
#  GUI: fonts,pango,X11
#  GTK: dconf,gconf,gtk-2.0,gtk-3.0
#  KDE: kde4rc,kde5rc
#  Networking: ca-certificates,crypto-policies,host.conf,hostname,hosts,nsswitch.conf,pki,protocols,resolv.conf,rpc,services,ssl
#    Extra: gai.conf,proxychains.conf
#  Qt: Trolltech.conf
##private-lib LIBS
## Note: private-opt copies the entire path(s) to RAM, which may break
## file-copy-limit in firejail.config (see firejail(1)).
## For sizeable apps (if in doubt, do this):
##  - never use 'private-opt NAME'
##  - place 'whitelist /opt/NAME' in the whitelist section above
## For acceptable apps:
##  - use 'private-opt NAME'
##private-opt NAME
#private-tmp
##writable-etc
##writable-run-user
##writable-var
##writable-var-log

# Since 0.9.63 also a more granular control of dbus is supported.
# To get the dbus-addresses an application needs access to you can
# check with flatpak (when the application is distributed that way):
#    flatpak remote-info --show-metadata flathub <APP-ID>
# Notes:
#  - flatpak implicitly allows an app to own <APP-ID> on the session bus
#  - Some features like native notifications are implemented as portal too.
#  - In order to make dconf work (when used by the app) you need to allow
#    'ca.desrt.dconf' even when not allowed by flatpak.
# Notes and policies about addresses can be found at
# <https://github.com/netblue30/firejail/wiki/Restrict-DBus>
#dbus-user filter
#dbus-user.own com.github.netblue30.firejail
#dbus-user.talk ca.desrt.dconf
#dbus-user.talk org.freedesktop.Notifications
#dbus-system none

# Note: read-only entries should usually go in disable-common.inc (especially
# entries for configuration files that allow arbitrary command execution).
##deterministic-shutdown
##env VAR=VALUE
##join-or-start NAME
#memory-deny-write-execute
##noexec PATH
##read-only ${HOME}
##read-write ${HOME}
#restrict-namespaces

include /etc/firejail/disable-common.inc
whitelist ~/Downloads
whitelist ~/Pictures
whitelist ~/Videos
whitelist ~/.firejail/vesktop/
whitelist ~/.config/vesktop
include /etc/firejail/whitelist-common.inc
private-tmp
private-dev
blacklist /mnt
blacklist /media

