# VolumeLeaders Chart Launcher - Windows Installation

This guide explains how to install the VolumeLeaders Chart Launcher (`vl`) as a global command line tool on Windows.

## Prerequisites

- Python 3.6 or higher installed
- Google Chrome or Microsoft Edge browser

## Installation Options

### Option 1: Add to PATH (Recommended)

1. Clone or download this repository to a permanent location on your computer.
2. Add the `bin` directory to your system PATH:
   - Press Win+S and search for "Environment Variables"
   - Click "Edit the system environment variables"
   - Click "Environment Variables" button
   - Under "System variables" or "User variables", find the "Path" variable
   - Click "Edit"
   - Click "New"
   - Add the full path to the `bin` directory (e.g., `C:\Users\YourName\vl-tap\bin`)
   - Click "OK" on all dialogs

3. Open a new Command Prompt or PowerShell window and test by typing:
   ```
   vl AAPL
   ```

### Option 2: Copy to Windows Directory

1. Copy `bin/vl`, `bin/vl.bat`, and `bin/vl.ps1` to a directory that's already in your PATH, such as:
   - `C:\Windows` (requires administrator privileges)
   - `C:\Users\YourName\AppData\Local\Microsoft\WindowsApps`

2. Open a new Command Prompt and test by typing:
   ```
   vl AAPL
   ```

### Option 3: Create a Shortcut

1. Create a shortcut to `bin/vl.bat` on your desktop or taskbar
2. Edit the shortcut properties to:
   - Set "Start in" to the directory containing the script
   - Add `%1` to the end of the Target field to pass arguments

## Usage

```
vl TICKER
```

Example:
```
vl AAPL
vl MSFT
vl TSLA
```

## Troubleshooting

- If you get a "not recognized as an internal or external command" error, make sure the directory is in your PATH.
- If you get a Python error, make sure Python is installed and in your PATH.
- If browser windows don't open correctly, try running as administrator.
- If windows don't position correctly, try closing all existing browser windows first.

## Notes

- The script will automatically detect Chrome or Edge browsers.
- For best results, close all existing browser windows before running the command.
- The script will always open new browser windows with the correct URLs. 