xsetrootname() {
    STATUS=$(amixer sget Master | tail -n1 | sed -r "s/.*\[(.*)\]/\1/")
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    if [ "$STATUS" = "off" ]; then
        printf "VOL MUTE"
    else
        printf "VOL %s%%" "$VOL"
    fi

    printf " / "

    CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)
    printf "BAT %s%% %s" "$CAPACITY" "$STATUS"

    printf " / "

    printf "$(date +"%F %R")"
}

while true; do
	xsetroot -name "$(xsetrootname)"
	sleep 2
done
