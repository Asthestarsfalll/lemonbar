#!/bin/sh

bat_text=$(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+")
[ ! "$bat_text" ] && bat_text=$(acpi -b | sed 2d | awk '{print $5}' | grep -Eo "[0-9]+")
[ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] && charge_icon=""
if   [ "$bat_text" -ge 95 ]; then bat_icon=""; charge_icon="";
elif [ "$bat_text" -ge 90 ]; then bat_icon="";
elif [ "$bat_text" -ge 80 ]; then bat_icon="";
elif [ "$bat_text" -ge 70 ]; then bat_icon="";
elif [ "$bat_text" -ge 60 ]; then bat_icon="";
elif [ "$bat_text" -ge 50 ]; then bat_icon="";
elif [ "$bat_text" -ge 40 ]; then bat_icon="";
elif [ "$bat_text" -ge 30 ]; then bat_icon="";
elif [ "$bat_text" -ge 20 ]; then bat_icon="";
elif [ "$bat_text" -ge 10 ]; then bat_icon="";
else bat_icon=""; fi

bat_text=$bat_text%
bat_icon=$charge_icon$bat_icon

text="$bat_icon $bat_text"
echo $text

