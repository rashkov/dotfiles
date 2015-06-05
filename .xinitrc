setxkbmap -option caps:hyper &
redshift &
xscreensaver -no-splash &
xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1 &
xrdb -merge ~/.Xresources
exec awesome -c ~/.config/awesome/rc.lua
