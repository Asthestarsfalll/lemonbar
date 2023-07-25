#/bin/sh

time_text="$(date '+%m/%d %H:%M')"
case "$(date '+%I')" in
    "01") time_icon="" ;;
    "02") time_icon="" ;;
    "03") time_icon="" ;;
    "04") time_icon="" ;;
    "05") time_icon="" ;;
    "06") time_icon="" ;;
    "07") time_icon="" ;;
    "08") time_icon="" ;;
    "09") time_icon="" ;;
    "10") time_icon="" ;;
    "11") time_icon="" ;;
    "12") time_icon="" ;;
esac

text="$time_icon $time_text"
echo $text
