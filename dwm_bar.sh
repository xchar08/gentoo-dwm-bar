# Network
network() {
  local ssid=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d':' -f2)
  if [ -n "$ssid" ]; then
    echo "📡 $ssid"
  else
    echo "🌐 Disconnected"
  fi
}

# Main loop
while true; do

  # Network
  network=$(network)

  # Volume
  volume=$(amixer get Master | awk -F'[][]' '/%/ {print $2}' | head -n1 | tr -d '%')
  if [ -z "$volume" ]; then
    # Check if audio is muted
    if pactl list sinks | grep 'Mute:' | grep -c 'yes' >/dev/null; then
      volume="$(amixer get Master | awk -F'[][]' '/%/ {print $2}' | head -n1 | tr -d '%')% 🔇"
    else
      volume="0% 🔈"
    fi
  else
    if [ "$volume" -ge 75 ]; then
      volume_emoji="🔊"
    elif [ "$volume" -ge 25 ]; then
      volume_emoji="🔉"
    else
      volume_emoji="🔈"
    fi
    volume="$volume% $volume_emoji"
    # Check if audio is muted
    if pactl list sinks | grep -q 'Mute: yes'; then
      volume="$(amixer get Master | awk -F'[][]' '/%/ {print $2}' | head -n1 | tr -d '%')% 🔇"
    fi
  fi

  # Weather
  weather=$(curl -s "wttr.in/?format=%C+%t+%h")

  # Get the temperature and humidity from the weather string
  temperature=$(echo "$weather" | awk '{print $2}')
  humidity=$(echo "$weather" | awk '{print $3}')

  # Get the weather condition from the weather string and match it to an emoji
  case "$weather" in
    *"Clear"*) weather_emoji="☀️";;
    *"sunny"*) weather_emoji="☀️";;
    *"partly cloudy"*) weather_emoji="⛅";;
    *"cloudy"*) weather_emoji="☁️";;
    *"Overcast"*) weather_emoji="☁️";;
    *"mist"*) weather_emoji="🌫️";;
    *"fog"*) weather_emoji="🌫️";;
    *"Haze"*) weather_emoji="🌫️";;
    *"light rain"*) weather_emoji="🌧️";;
    *"rain"*) weather_emoji="🌧️";;
    *"heavy rain"*) weather_emoji="🌧️";;
    *"thunderstorm"*) weather_emoji="⛈️";;
    *"snow"*) weather_emoji="❄️";;
    *"hail"*) weather_emoji="❄️";;
    *) weather_emoji="❓";;
  esac

  # Time
  time=$(date +"%I:%M:%S %p %Z")

  # Calendar date
  date=$(date +"%a %d %b")

  # RAM usage
  ram=$(free -h | awk '/^Mem:/ {print $3}')

  # CPU usage
  cpu=$(top -bn1 | awk '/^%Cpu/ {printf "%.1f%", $2}')

  # Uptime
  uptime=$(uptime -p | sed 's/up //')

  # Battery status
  battery=$(acpi -b | awk '/Battery 0/ {print $4}' | tr -d '%,')
  if [ -z "$battery" ]; then
    battery="AC"
  else
    if [ $(echo "$battery < 20" | bc) -ne 0 ]; then
      battery_emoji="🔴"
    elif [ $(echo "$battery < 50" | bc) -ne 0 ]; then
      battery_emoji="🟡"
    else
      battery_emoji="🟢"
    fi
    battery="$battery% $battery_emoji"
  fi

  # Set the bar using xsetroot
  xsetroot -name " $network | $weather_emoji $temperature $humidity | ⏰ $time | 📅 $date | 💾 $ram | 💻 $cpu | $volume | 🔋 $battery | ⏳ $uptime "

done
