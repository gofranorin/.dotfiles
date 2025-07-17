#!/bin/bash

choice=$(printf "   Emojis\n  Power Menu\n   Bluetooth" | rofi -dmenu -p "  Menu:")

case "$choice" in
    "   Emojis")
        ~/.config/rofi/scripts/emojis.sh
        ;;
    "  Power Menu")
	rofi -show power-menu -modi power-menu:rofi-power-menu
        ;;
    "   Bluetooth")
	rofi-bluetooth     
        ;;
  esac



#/sbin/rofi -modes run -show




