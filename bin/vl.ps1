# VolumeLeaders Chart Launcher - PowerShell Script
# This file should be placed in a directory that's in your PATH

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Try to call the Python script with all arguments
try {
    python "$scriptDir\vl" $args
} catch {
    # If python command fails, try with python3
    try {
        python3 "$scriptDir\vl" $args
    } catch {
        Write-Host "Error: Could not run Python script. Please make sure Python is installed and in your PATH."
        exit 1
    }
} 