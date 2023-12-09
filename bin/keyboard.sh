#!/bin/bash

# console: man keyboard;  /etc/default/keyboard
# On hedgehog, in /etc/default/keyboard
# XKBOPTIONS="caps:ctrl_modifier,ctrl:ralt_rctrl,ctrl:rctrl_ralt,shift:both_capslock"
# On goose
# XKBOPTIONS="caps:ctrl_modifier,altwin:swap_lalt_lwin,ctrl:swap_rwin_rctl,shift:both_capslock"

if [[ "$(hostname)" = "asusbox" ]]; then
setxkbmap -option # back to default
setxkbmap -option caps:ctrl_modifier
setxkbmap -option ctrl:ralt_rctrl
setxkbmap -option altwin:menu_win
setxkbmap -option shift:both_capslock

for id in $(xinput list | sed -e '1,/Virtual core keyboard/d' | grep -e 'Keychron' -e 'PCoIP.*Keyboard' -e 'RGS keyboard' | sed -e 's/.*id=\([0-9]\+\).*/\1/')
do
	setxkbmap -device "${id}" -option
	setxkbmap -device "${id}" -option caps:ctrl_modifier
	setxkbmap -device "${id}" -option ctrl:swap_rwin_rctl
	setxkbmap -device "${id}" -option altwin:swap_lalt_lwin
	setxkbmap -device "${id}" -option shift:both_capslock
done
fi

if [[ "$XDG_CURRENT_DESKTOP" = "ubuntu:GNOME" ]]; then
    # stop Ctrl-. getting blocked
    gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]"
fi

if [[ "$XDG_CURRENT_DESKTOP" = "MATE" ]]; then
    gsettings set org.mate.interface gtk-key-theme Emacs
    # disable Super_L key opening menu
    gsettings set org.mate.mate-menu hot-key ''
    gsettings set com.solus-project.brisk-menu hot-key ''
    # disable Super_L-E opening file explorer
    gsettings set org.mate.Marco.global-keybindings run-command-3 ''
fi

# https://docs.microsoft.com/en-us/sysinternals/downloads/ctrl2cap
# https://github.com/microsoft/PowerToys/releases/
