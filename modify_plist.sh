#!/bin/bash

# Path to the Info.plist file
PLIST_PATH=~/Applications/RunVLIndex.app/Contents/Info.plist

# Backup the original plist
cp "$PLIST_PATH" "$PLIST_PATH.bak"

# Update the CFBundleDisplayName and CFBundleName
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName 'VL Index'" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :CFBundleName 'VL Index'" "$PLIST_PATH"

# Add a description
/usr/libexec/PlistBuddy -c "Add :NSHumanReadableCopyright string 'Volume Leaders Index Charts Viewer'" "$PLIST_PATH" 2>/dev/null

echo "App Info.plist has been updated." 