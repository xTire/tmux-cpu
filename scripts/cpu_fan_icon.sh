#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/helpers.sh"

# script global variables
cpu_fan_low_icon=""
cpu_fan_medium_icon=""
cpu_fan_high_icon=""

cpu_fan_low_default_icon="_"
cpu_fan_medium_default_icon="≡"
cpu_fan_high_default_icon="≣"

# icons are set as script global variables
get_icon_settings() {
  cpu_fan_low_icon=$(get_tmux_option "@cpu_fan_low_icon" "$cpu_fan_low_default_icon")
  cpu_fan_medium_icon=$(get_tmux_option "@cpu_fan_medium_icon" "$cpu_fan_medium_default_icon")
  cpu_fan_high_icon=$(get_tmux_option "@cpu_fan_high_icon" "$cpu_fan_high_default_icon")
}

print_icon() {
  local cpu_fan
  local cpu_fan_status
  cpu_fan=$("$CURRENT_DIR"/cpu_fan.sh | sed -e 's/[^0-9.]//')
  cpu_fan_status=$(fan_status "$cpu_fan")
  if [ "$cpu_fan_status" == "low" ]; then
    echo "$cpu_fan_low_icon"
  elif [ "$cpu_fan_status" == "medium" ]; then
    echo "$cpu_fan_medium_icon"
  elif [ "$cpu_fan_status" == "high" ]; then
    echo "$cpu_fan_high_icon"
  fi
}

main() {
  get_icon_settings
  print_icon "$1"
}
main "$@"
