#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_uptime() {
  if is_linux; then
    function getRamUsage() {
        ramUsage=$(free -m | grep $memKeyword | awk '{print $3/$2 * 100}' | cut -f1 -d".")
    }

    memKeyword="Mem"
    getRamUsage

    if [ -z "$ramUsage" ]; then
        memKeyword="Pam"
        getRamUsage
    fi
    echo "$ramUsage%"
  elif is_osx; then
    top -l 1 -s 0 | grep PhysMem | awk '{print $2}'
  fi
}

main() {
  print_uptime
}

main
