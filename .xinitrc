while true; do
  wmsetstatus
  sleep 7
done &
dunst &
while true; do
  dwm 2> ~/.dwm.log
done
