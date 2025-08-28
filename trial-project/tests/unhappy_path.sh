#!/usr/bin/env bash
set -e

echo "Running UNHAPPY PATH test..."

# Reset data file
rm -f shifts.json
set +e
/home/prybrnl/mini-project-1-github-with-tests/shift_manager_simple.sh <<EOF
Alice
morning
A1
Bob
morning
A1
Charlie
morning
A1
EOF
status=$?
set -e

if [ $status -eq 1 ]; then
  echo "UNHAPPY PATH test passed (exited with error as expected)."
else
  echo "UNHAPPY PATH test failed (unexpected exit code: $status)."
  exit 1
fi
