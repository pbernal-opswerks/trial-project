#!/usr/bin/env bash
# Simple version of shift_manager.sh

DATA_FILE="shifts.json"


# Make sure jq is installed
if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required. Install with: sudo apt install jq"
  exit 1
fi

# If no data file exists, initialize it
if [ ! -f "$DATA_FILE" ]; then
  cat > "$DATA_FILE" <<'JSON'
{
  "A1": { "morning": [], "mid": [], "night": [] },
  "A2": { "morning": [], "mid": [], "night": [] },
  "A3": { "morning": [], "mid": [], "night": [] },
  "B1": { "morning": [], "mid": [], "night": [] },
  "B2": { "morning": [], "mid": [], "night": [] },
  "B3": { "morning": [], "mid": [], "night": [] }
}
JSON
fi

# Main loop
while true; do
  echo
  read -p "Enter Employee Name: " name

  # Exit condition
  if [[ "${name,,}" == "print" ]]; then
    echo
    echo "+------+---------+----------------+"
    printf "| %-4s | %-7s | %-14s |\n" "Team" "Shift" "Employees"
    echo "+------+---------+----------------+"
    for team in A1 A2 A3 B1 B2 B3; do
      for shift in morning mid night; do
        employees=$(jq -r --arg t "$team" --arg s "$shift" '.[$t][$s] | join(", ")' "$DATA_FILE")
        if [ -n "$employees" ]; then
          printf "| %-4s | %-7s | %-14s |\n" "$team" "$shift" "$employees"
        fi
      done
    done
    echo "+------+---------+----------------+"
    exit 0
  fi

  # Ask shift
  read -p "Enter Shift (morning, mid, night): " shift
  shift="${shift,,}"
  if [[ ! " morning mid night " =~ " $shift " ]]; then
    echo "Invalid shift! Please choose morning, mid, or night."
    continue
  fi

  # Ask team
  read -p "Enter Team (A1, A2, A3, B1, B2, B3): " team
  team="${team^^}"
  if [[ ! " A1 A2 A3 B1 B2 B3 " =~ " $team " ]]; then
    echo "Invalid team! Please choose A1, A2, A3, B1, B2, or B3."
    continue
  fi

  # Check if already full
  count=$(jq -r --arg t "$team" --arg s "$shift" '.[$t][$s] | length' "$DATA_FILE")
  if [ "$count" -ge 2 ]; then
    echo "Error: Maximum employees per shift in team $team reached. Exiting..."
    exit 1
  fi

  # Add employee
  tmp=$(mktemp)
  jq --arg t "$team" --arg s "$shift" --arg n "$name" '.[$t][$s] += [$n]' "$DATA_FILE" > "$tmp"
  mv "$tmp" "$DATA_FILE"

  echo "Added $name to team $team ($shift shift)."
done
