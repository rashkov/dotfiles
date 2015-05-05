/usr/bin/start-pulseaudio-x11 &
setxkbmap -option caps:hyper &
redshift &
xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1 &
xrdb -merge ~/.Xresources
exec awesome -c ~/.config/awesome/rc.lua
