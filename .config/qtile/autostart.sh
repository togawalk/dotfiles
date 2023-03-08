#!/usr/bin/env bash

/usr/bin/emacs --daemon &
nitrogen --restore &
picom --experimental-backends &
xsetroot -cursor_name left_ptr &
setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle" &
