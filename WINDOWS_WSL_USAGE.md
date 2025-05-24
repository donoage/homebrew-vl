# VL Command for Windows/WSL

This document describes how to use the improved VL command on Windows and WSL.

## Windows Version Improvements

The Windows version (`vl-windows.py`) addresses two main issues with the original script:

1. **Window positioning happens too late**: Windows are now positioned immediately after they're opened.
2. **Doesn't reuse existing windows**: Now correctly finds and reuses existing browser windows.

## Using the Scripts

### From Windows:

Run the Windows script directly:

```
python bin\vl-windows.py TICKER
```

Example:
```
python bin\vl-windows.py AAPL
```

### From WSL:

Use the WSL wrapper script:

```
./bin/vl-wsl TICKER
```

Example:
```
./bin/vl-wsl AAPL
```

## Features

- **Window Handle Tracking**: Stores window handles between runs for faster reuse
- **Smarter Window Detection**: Prioritizes VolumeLeaders windows over other browser windows
- **Early Positioning**: Positions windows immediately after creation
- **Reliable Navigation**: Opens all URLs in the correct positions
- **Fallback Mechanisms**: Multiple strategies to ensure windows are found and positioned

## Options

- **Force New Windows**: Add `--force-new` to start fresh with new browser windows
  ```
  python bin\vl-windows.py AAPL --force-new
  ```

## Requirements

- Python 3.x installed on Windows
- Windows access from WSL (if running from WSL)
- Chrome or Edge browser installed

## Troubleshooting

If you encounter issues:

1. **No browser detected**: Make sure Chrome or Edge is installed in a standard location.

2. **Windows not positioning correctly**: Try the `--force-new` option to create fresh windows.

3. **WSL path issues**: Make sure the scripts are in the expected locations and have execute permissions.
   ```
   chmod +x bin/vl-wsl
   chmod +x bin/vl-windows.py
   ```

4. **Python not found in Windows**: Make sure Python is installed and in your Windows PATH.

## Implementation Details

The script works by:

1. Trying to find existing browser windows first
2. Creating new windows if necessary
3. Using direct Windows API calls through PowerShell to position windows
4. Storing window handles for future reuse 