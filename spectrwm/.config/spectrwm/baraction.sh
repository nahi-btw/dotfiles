#!/bin/sh
# ~/.config/spectrwm/bar_action.sh
# Text-only version with no special icons

# Main loop
while true; do
    # --- Battery Percentage ---
    BAT_PATH="/sys/class/power_supply/BAT0"
    if [ -d "$BAT_PATH" ]; then
        CAPACITY=$(cat "$BAT_PATH/capacity" 2>/dev/null)
        STATUS=$(cat "$BAT_PATH/status" 2>/dev/null | head -c 3)
        BAT_SYMBOL="BAT"
        case "$STATUS" in
            "Dis") BAT_SYMBOL="BAT" ;;
            "Cha") BAT_SYMBOL="CHG" ;;
            "Ful") BAT_SYMBOL="FULL" ;;
            *) BAT_SYMBOL="BAT?" ;;
        esac
        BAT_INFO="${BAT_SYMBOL} ${CAPACITY}%"
    else
        BAT_INFO="NO BAT"
    fi

    # --- Volume Level ---
    # Try pamixer first
    if command -v pamixer >/dev/null 2>&1; then
        VOLUME=$(pamixer --get-volume 2>/dev/null)
        MUTE_STATE=$(pamixer --get-mute 2>/dev/null)
        VOL_SYMBOL="VOL"
        if [ "$MUTE_STATE" = "true" ]; then
            VOL_SYMBOL="MUT"
        fi
        VOL_INFO="${VOL_SYMBOL} ${VOLUME}%"
    # Fallback to amixer
    elif command -v amixer >/dev/null 2>&1; then
        VOL_INFO=$(amixer sget Master 2>/dev/null | grep -o -m 1 '[0-9]*%\|\[on\]\|\[off\]' | tr '\n' ' ' | sed 's/\[on\]/VOL/; s/\[off\]/MUT/')
    else
        VOL_INFO="VOL N/A"
    fi

    # --- Network Connection ---
    # Try nmcli first
    if command -v nmcli >/dev/null 2>&1; then
        NET_INFO=$(nmcli -t -f NAME connection show --active 2>/dev/null | head -1)
        if [ -z "$NET_INFO" ]; then
            NET_INFO="NET Off"
        else
            # Shorten long network names
            if [ ${#NET_INFO} -gt 12 ]; then
                NET_INFO="NET:${NET_INFO:0:10}.."
            else
                NET_INFO="NET:${NET_INFO}"
            fi
        fi
    # Fallback for wireless
    elif command -v iwgetid >/dev/null 2>&1; then
        SSID=$(iwgetid -r 2>/dev/null)
        if [ -n "$SSID" ]; then
            if [ ${#SSID} -gt 12 ]; then
                NET_INFO="WIFI:${SSID:0:10}.."
            else
                NET_INFO="WIFI:${SSID}"
            fi
        else
            NET_INFO="NET Off"
        fi
    else
        NET_INFO="NET N/A"
    fi

    # --- Assemble the bar output ---
    # Format: +@fg=5;NET | +@fg=3;VOL | +@fg=6;BAT
    echo "+@fg=5;${NET_INFO} +@fg=3;| ${VOL_INFO} +@fg=3;| ${BAT_INFO}|"

    # Update interval
    sleep 3
done
update_display() {
    BAT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "??")
    VOL=$(pamixer --get-volume 2>/dev/null || echo "??")
    NET=$(iwgetid -r 2>/dev/null || echo "Off")
    echo "+@fg=5;NET:$NET +@fg=3;| VOL:$VOL% +@fg=3;| BAT:$BAT%"
}

update_display

# Update on volume events (fast)
pactl subscribe | grep -E "sink|source" | while read -r; do
    update_display
done &
