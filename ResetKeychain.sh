#!/bin/sh
# Created for & by Nurax AI
# 26 Jan 2025 - Happy Republic Day, India 🇮🇳

# Define Variables
KEYCHAIN_DIR="$HOME/Library/Keychains"
BACKUP_DIR="$HOME/Library/Nuraxai/KeychainBackup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_KEYCHAIN_DIR="$BACKUP_DIR/KeychainBackup_$DATE"

# Step 1: Show AppleScript dialog to warn the user
osascript <<EOF
display dialog "This will reset your keychain. All your old saved passwords will be removed and backed up. Do you want to continue?" buttons {"Cancel", "Proceed"} default button "Proceed"
EOF

# Check the exit status of the dialog
if [ $? -ne 0 ]; then
  echo "User canceled the operation."
  exit 1
fi

# Step 2: Backup the current keychain
echo "Backing up the Keychain..."
mkdir -p "$BACKUP_KEYCHAIN_DIR"
cp -R "$KEYCHAIN_DIR"/* "$BACKUP_KEYCHAIN_DIR"

if [ $? -eq 0 ]; then
  echo "Keychain successfully backed up to: $BACKUP_KEYCHAIN_DIR"
else
  echo "Failed to back up Keychain. Aborting."
  exit 1
fi

# Step 3: Delete the existing keychain
echo "Deleting existing keychain..."
rm -rf "$KEYCHAIN_DIR"/*

if [ $? -eq 0 ]; then
  echo "Keychain successfully deleted."
else
  echo "Failed to delete Keychain. Aborting."
  exit 1
fi

# Step 4: Create a new default keychain
echo "Creating a new keychain..."
security create-keychain -p "" login.keychain-db

if [ $? -eq 0 ]; then
  echo "New keychain successfully created."
else
  echo "Failed to create a new keychain. Aborting."
  exit 1
fi

echo "Keychain reset completed. A backup has been saved at: $BACKUP_KEYCHAIN_DIR"

exit 0
