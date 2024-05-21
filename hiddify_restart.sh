#!/bin/bash

# Function to restart HiddifyPanel
restart_hiddify() {
    echo "Restarting HiddifyPanel"
    systemctl restart hiddify-panel
}

# Get the number of hours from the user
read -p "Please enter the number of hours between each restart: " hours

# Check if the input is a valid number
if ! [[ "$hours" =~ ^[0-9]+$ ]] ; then
   echo "Invalid input. Please enter a number."
   exit 1
fi

# Create a script to restart HiddifyPanel
cat <<EOF > /usr/local/bin/restart_hiddify.sh
#!/bin/bash
echo "Restarting HiddifyPanel"
systemctl restart hiddify-panel
EOF

# Make the script executable
chmod +x /usr/local/bin/restart_hiddify.sh

# Remove any existing cron job for this script
(crontab -l | grep -v 'restart_hiddify.sh') | crontab -

# Add a new cron job to run the script every N hours
cron_line="0 */$hours * * * /usr/local/bin/restart_hiddify.sh"
(crontab -l ; echo "$cron_line") | crontab -

echo "Cron job set to restart HiddifyPanel every $hours hours."
