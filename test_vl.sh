#!/bin/bash

# Path to the vl command
VL_COMMAND="/opt/homebrew/bin/vl"

# Check if the command exists
if [ -f "$VL_COMMAND" ]; then
    echo "vl command found at: $VL_COMMAND"
else
    echo "ERROR: vl command not found at $VL_COMMAND"
    exit 1
fi

# Check if the command is executable
if [ -x "$VL_COMMAND" ]; then
    echo "vl command is executable"
else
    echo "ERROR: vl command is not executable"
    exit 1
fi

# Run the command in index mode
echo "Running vl -i command..."
"$VL_COMMAND" -i

echo "Done" 