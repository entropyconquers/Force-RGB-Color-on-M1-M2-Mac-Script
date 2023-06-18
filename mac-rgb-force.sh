#!/bin/bash

# Function to display an error message and exit
function error_exit {
    echo "Error: $1" >&2
    exit 1
}

# Function to check if a command executed successfully
function check_success {
    if [ $? -ne 0 ]; then
        error_exit "Command failed: $1"
    fi
}

# Step 1 - Unlock the file
sudo chflags nouchg /Library/Preferences/com.apple.windowserver.displays.plist
check_success "Unlocking the file"
echo "Step 1: File unlocked successfully."

# Step 2 - Copy the file to your home directory
cp /Library/Preferences/com.apple.windowserver.displays.plist ~/Downloads/
check_success "Copying the file"
echo "Step 2: File copied successfully."

# Step 3 - Convert the file to JSON
plutil -convert json ~/Downloads/com.apple.windowserver.displays.plist -o ~/Downloads/com.apple.windowserver.displays.json
check_success "Converting the file to JSON"
echo "Step 3: File converted to JSON successfully."

# Step 4 - Run python script to change the file, edit_json.py located in the same directory as this script, run as sudo
# and read the output back from python script
var=$(sudo python3 edit_json.py)
check_success "Running the python script"
echo "Step 4: Python script executed successfully."

# Step 5 - Convert the file back to binary
plutil -convert binary1 ~/Downloads/com.apple.windowserver.displays.json -o ~/Downloads/com.apple.windowserver.displays.plist
check_success "Converting the file back to binary"
echo "Step 5: File converted back to binary successfully."

# Step 6 - Check if valid plist
plutil -lint ~/Downloads/com.apple.windowserver.displays.plist
check_success "Checking if the plist is valid"
echo "Step 6: Plist validation successful."

# Step 7 - Rename the original file _backup
sudo mv /Library/Preferences/com.apple.windowserver.displays.plist /Library/Preferences/com.apple.windowserver.displays.plist_backup
check_success "Renaming the original file"
echo "Step 7: Original file renamed successfully."

# Step 8 - Rename ~/Library/Preferences/com.apple.windowserver.displays.plist to com.apple.windowserver.displays.plist_backup if it exists
if [ -f ~/Library/Preferences/com.apple.windowserver.displays.plist ]; then
    mv ~/Library/Preferences/com.apple.windowserver.displays.plist ~/Library/Preferences/com.apple.windowserver.displays.plist_backup
    check_success "Renaming user preferences file"
    echo "Step 8: User preferences file renamed successfully."
fi

# Step 9 - Rename /Users/yourname/Library/Preferences/ByHost/com.apple.windowserver.displays.[UDID].plist to com.apple.windowserver.displays.[UDID].plist_backup if it exists
# The UUID can be anything, so we use a wildcard
if [ -f ~/Library/Preferences/ByHost/com.apple.windowserver.displays.*.plist ]; then
    mv ~/Library/Preferences/ByHost/com.apple.windowserver.displays.*.plist ~/Library/Preferences/ByHost/com.apple.windowserver.displays.*.plist_backup
    check_success "Renaming ByHost preferences file"
    echo "Step 9: ByHost preferences file renamed successfully."
fi

# Step 10 - Copy the new file to the original location
sudo cp ~/Downloads/com.apple.windowserver.displays.plist /Library/Preferences/com.apple.windowserver.displays.plist
check_success "Copying the new file"
echo "Step 10: New file copied to original location successfully."

# Step 11 - Lock the file
sudo chflags uchg /Library/Preferences/com.apple.windowserver.displays.plist
check_success "Locking the file"
echo "Step 11: File locked successfully."

# Step 12 - Delete the temporary file and the json file
rm ~/Downloads/com.apple.windowserver.displays.plist
check_success "Deleting temporary files"
echo "Step 12: Temporary files deleted successfully."

rm ~/Downloads/com.apple.windowserver.displays.json
check_success "Deleting temporary files"
echo "Step 12: Temporary files deleted successfully."

# Ask for confirmation before restarting
read -p "Step 13: Restart required. Do you want to restart the computer now? (Y/N): " choice
case "$choice" in
    y|Y )
        # Step 13 - Restart the computer
        sudo shutdown -r now
        ;;
    n|N )
        echo "Step 13: Restart canceled."
        ;;
    * )
        echo "Invalid choice. Restart canceled."
        ;;
esac
