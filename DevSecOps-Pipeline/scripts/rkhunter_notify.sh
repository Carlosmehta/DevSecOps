#!/bin/bash
LOGFILE="/var/log/rkhunter.log"
TMPFILE="/tmp/rkhunter_warnings.txt"

sudo rkhunter --update
sudo rkhunter --cronjob --report-warnings-only

grep -i "Warning" $LOGFILE > $TMPFILE

if [ -s $TMPFILE ]; then
    echo "🚨 RKHunter Alert on $(hostname)"
    cat $TMPFILE
else
    echo "✅ No RKHunter warnings."
fi

rm -f $TMPFILE
