#!/usr/bin/env bash
set -e

echo "Running HAPPY PATH test..."

# Reset data file
rm -f shifts.json
/home/prybrnl/mini-project-1-github-with-tests/shift_manager_simple.sh <<EOF
Alice
morning
A1
Bob
morning
A1
print
EOF

echo "HAPPY PATH test finished."
