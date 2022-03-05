#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/helpers.sh"

cpu_fan_low_bg_color=""
cpu_fan_medium_bg_color=""
cpu_fan_high_bg_color=""

cpu_fan_low_default_bg_color="#[bg=green]"
cpu_fan_medium_default_bg_color="#[bg=yellow]"
cpu_fan_high_default_bg_color="#[bg=red]"

get_bg_color_settings() {
  cpu_fan_low_bg_color=$(get_tmux_option "@cpu_fan_low_bg_color" "$cpu_fan_low_default_bg_color")
  cpu_fan_medium_bg_color=$(get_tmux_option "@cpu_fan_medium_bg_color" "$cpu_fan_medium_default_bg_color")
  cpu_fan_high_bg_color=$(get_tmux_option "@cpu_fan_high_bg_color" "$cpu_fan_high_default_bg_color")
}

print_bg_color() {
  local cpu_fan
  local cpu_fan_status
  cpu_fan=$("$CURRENT_DIR"/cpu_fan.sh | sed -e 's/[^0-9.]//')
  cpu_fan_status=$(fan_status "$cpu_fan")
  if [ "$cpu_fan_status" == "low" ]; then
    echo "$cpu_fan_low_bg_color"
  elif [ "$cpu_fan_status" == "medium" ]; then
    echo "$cpu_fan_medium_bg_color"
  elif [ "$cpu_fan_status" == "high" ]; then
    echo "$cpu_fan_high_bg_color"
  fi
}

main() {
  get_bg_color_settings
  print_bg_color
}
main
