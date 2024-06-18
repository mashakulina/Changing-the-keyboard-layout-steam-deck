#!/bin/bash

# if a password was set, this will run when the program closes
temp_pass_cleanup() {
  echo $PASS | sudo -S -k passwd -d deck
}

# removes unhelpful GTK warnings
zen_nospam() {
  zenity 2> >(grep -v 'Gtk' >&2) "$@"
}

# if the script is not root yet, get the password and rerun as root
if (( $EUID != 0 )); then
    PASS_STATUS=$(passwd -S deck 2> /dev/null)

    # get password
    while [ "$PASSWORD" != "true" ]; do
        PASS=$(zen_nospam --title="Adding a layout change" --width=300 --height=100 --entry --hide-text --text="Enter your sudo/admin password")
        if [[ $? -eq 1 ]] || [[ $? -eq 5 ]]; then
        exit 1
        fi
    if ( echo "$PASS" | sudo -S -k true ); then
        PASSWORD="true"
    else
        zen_nospam --title="Adding a layout change" --width=150 --height=40 --info --text "Incorrect Password"
    fi
  done
  echo "$PASS" | sudo -S -k bash "$0" "$@" # rerun script as root
  exit 1

fi

# if layout change is already present in environment, then add 'recovery' option
if grep -q "XKB_DEFAULT_LAYOUT" /etc/environment ; then
    OPTION=$(zen_nospam --title="Adding a layout change" --width=350 --height=200 --list --radiolist --text "The layout change is already added\nSelect Option:" --hide-header --column "Buttons" --column "Choice"\
    TRUE "Recovery system file" \
    )
else
  echo "Backup environment..."
  sudo cp /etc/environment /etc/environment.bak

  # Select layout
  OPTION=$(zen_nospam --title="Layout switching option" --width=350 --height=350 --list --radiolist --text "Select the option to switch the layout:" --hide-header --column "Buttons" --column "Choice"\
    TRUE "shift+ctrl" \
    FALSE "shift+alt" \
    )

  if [[ "$OPTION" == "shift+ctrl" ]]; then
  # Select shift+ctrl
  echo "Adding parameter in environment..."
  sudo sed -i '5 a\XKB_DEFAULT_LAYOUT=ru,us\nXKB_DEFAULT_OPTIONS=grp:lctrl_lshift_toggle\n' /etc/environment
  else
  # Select shift+alt
  echo "Adding parameter in environment..."
  sudo sed -i '5 a\XKB_DEFAULT_LAYOUT=ru,us\nXKB_DEFAULT_OPTIONS=grp:lalt_lshift_toggle\n' /etc/environment
  fi

  # Reboot/Later
  if grep -q "XKB_DEFAULT_LAYOUT" /etc/environment ; then
      OPTION=$(zen_nospam --title="Adding a layout change" --width=350 --height=100 --list --radiolist --text "Reboot system:" --hide-header --column "Buttons" --column "Choice"\
      TRUE "Reboot now" \
      FALSE "Reboot later"
      )
  fi
    # Reboot later
    if [ "$OPTION" == "Reboot later" ]; then
        zen_nospam --title="Adding a layout change" --width=150 --height=40 --info --text "Don't forget to reboot your system later"
        exit 0
    else
    # Reboot after recovery
        echo "Reboot!"
        shutdown now -r
    fi
fi

# Recovery system file if recovery option was selected
if [ "$OPTION" == "Recovery system file" ] ; then
    (
    echo "Delete old Environment...";
    sudo rm /etc/environment
    echo "Environment recovery from bakup...";
    sudo mv /etc/environment.bak /etc/environment

    # Reboot/Later
    OPTION=$(zen_nospam --title="Adding a layout change" --width=350 --height=100 --list --radiolist --text "Reboot system:" --hide-header --column "Buttons" --column "Choice"\
    TRUE "Reboot now" \
    FALSE "Reboot later")

    # Reboot later
    if [ "$OPTION" == "Reboot later" ]; then
        zen_nospam --title="Adding a layout change" --width=150 --height=40 --info --text "Don't forget to reboot your system later"
        exit 0
    else
    # Reboot after recovery
        echo "Reboot!"
        shutdown now -r
    fi
  )
fi
