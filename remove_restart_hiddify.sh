#!/bin/bash

# Remove the cron job for restart_hiddify.sh
(crontab -l | grep -v '/usr/local/bin/restart_hiddify.sh') | crontab -

echo "Cron job for restarting HiddifyPanel has been removed."
