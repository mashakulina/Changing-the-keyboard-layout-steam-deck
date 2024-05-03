#!/bin/bash

# Check if changing the keyboard layout is present in environment
if grep -q "XKB_DEFAULT_LAYOUT=ru,us" /etc/environment; then
  # Delete old Environment
  echo "Delete old Environment..."  
  sleep 1
  rm /etc/environment
  
  #Environment recovery from bakup
  echo "Environment recovery from bakup..."  
  sleep 1  
  mv /etc/environment.bak /etc/environment

  # Reboot after recovery
  for i in {3..1}; do
    echo "Reboot in $i seconds..."
    sleep 1
  done
echo "Reboot!"
shutdown now -r  

else
  # Changing the keyboard layout has already been deleted
  echo "Changing the keyboard layoute has already been deleted..."
  sleep 3
fi
