#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/helpers.sh"

cpu_fan_low_fg_color=""
cpu_fan_medium_fg_color=""
cpu_fan_high_fg_color=""

cpu_fan_low_default_fg_color="#[fg=green]"
cpu_fan_medium_default_fg_color="#[fg=yellow]"
cpu_fan_high_default_fg_color="#[fg=red]"

get_fg_color_settings() {
  cpu_fan_low_fg_color=$(get_tmux_option "@cpu_fan_low_fg_color" "$cpu_fan_low_default_fg_color")
  cpu_fan_medium_fg_color=$(get_tmux_option "@cpu_fan_medium_fg_color" "$cpu_fan_medium_default_fg_color")
  cpu_fan_high_fg_color=$(get_tmux_option "@cpu_fan_high_fg_color" "$cpu_fan_high_default_fg_color")
}

print_fg_color() {
  local cpu_fan
  local cpu_fan_status
  cpu_fan=$("$CURRENT_DIR"/cpu_fan.sh | sed -e 's/[^0-9.]//')
  cpu_fan_status=$(fan_status "$cpu_fan")
  if [ "$cpu_fan_status" == "low" ]; then
    echo "$cpu_fan_low_fg_color"
  elif [ "$cpu_fan_status" == "medium" ]; then
    echo "$cpu_fan_medium_fg_color"
  elif [ "$cpu_fan_status" == "high" ]; then
    echo "$cpu_fan_high_fg_color"
  fi
}

main() {
  get_fg_color_settings
  print_fg_color
}
main
