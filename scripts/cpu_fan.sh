#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/helpers.sh"

cpu_fan_format="%4s"

print_cpu_fan() {
  cpu_fan_format=$(get_tmux_option "@cpu_fan_format" "$cpu_fan_format")
  if command_exists "sensors"; then
    local val
    val="$(sensors)"
  fi
  echo "$val" | grep fan1 | awk -v format="$cpu_fan_format" '{print $2$3}'
}

main() {
  print_cpu_fan
}
main
