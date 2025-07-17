#!/usr/bin/env bash

# Simple stand-alone wrapper for rofi-power-menu.
#
# This script takes the same CLI arguments as rofi-power-menu.
#
# rofi-script-to-dmenu needs to be installed

# Use local rofi-power-menu if present. This makes developing easier.
command -v ~/.config/rofi/scripts/power-menu.sh >/dev/null
powermenu_exists=$?
if [ $powermenu_exists -eq 0 ]
then
    powermenu="~/.config/rofi/scripts/power-menu.sh"
else
    powermenu="rofi-power-menu"
fi

cmd="$powermenu $@"
rofi-script-to-dmenu "$cmd"
