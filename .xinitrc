setxkbmap -option caps:hyper &
xrdb -merge ~/.Xresources
xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1 --primary &
redshift &
xscreensaver -no-splash &
exec awesome -c ~/.config/awesome/rc.lua
