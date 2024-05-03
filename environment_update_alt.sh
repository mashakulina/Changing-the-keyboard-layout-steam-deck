#!/bin/bash

# Check if the new value is already present in environment
if grep -q "XKB_DEFAULT_LAYOUT" /etc/environment; then
  echo "Changing the keyboard layout already add in environment"
  sleep 3
else
  # Backup the original file
  echo "Backup environment..."
  sleep 1
  cp /etc/environment /etc/environment.bak
  
  # Add the new value to environment
  echo "Adding parameter in environment..."
  sleep 1
  sed -i '5 a\XKB_DEFAULT_LAYOUT=ru,us\nXKB_DEFAULT_OPTIONS=grp:lalt_lshift_toggle\n' /etc/environment
  
  # Reboot after a countdown
  for i in {3..1}; do
    echo "Reboot in $i seconds..."
    sleep 1
  done

echo "Reboot!"
shutdown now -r
fi