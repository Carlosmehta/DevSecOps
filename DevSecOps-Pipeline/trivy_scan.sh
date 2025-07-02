#!/bin/bash
REPORT="/tmp/trivy_report.txt"

trivy filesystem --severity CRITICAL,HIGH --no-progress / > $REPORT

if grep -q 'CRITICAL\|HIGH' $REPORT; then
  echo "⚠️ Trivy found vulnerabilities:"
  tail -n 15 $REPORT
else
  echo "✅ No critical/high vulnerabilities found."
fi


