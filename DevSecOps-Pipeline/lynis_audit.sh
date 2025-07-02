#!/bin/bash
REPORT="/tmp/lynis_report.txt"

sudo lynis audit system --quiet > $REPORT

WARNINGS=$(grep 'Warning' $REPORT | wc -l)

if [ "$WARNINGS" -gt 0 ]; then
  echo "🔍 Lynis audit found $WARNINGS warnings."
  tail -n 10 $REPORT
else
  echo "✅ No Lynis warnings."
fi

