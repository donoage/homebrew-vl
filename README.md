# VolumeLeaders

A command-line tool to open stock charts on VolumeLeaders.com.

## Installation

```bash
brew tap donoage/vl
brew install vl
```

Or install directly:

```bash
brew install donoage/vl/vl
```

## Usage

```bash
# Open VolumeLeaders chart for a specific ticker
vl AAPL

# Display help
vl
```

## Features

- Simple command-line interface
- Smart window management - detects and reuses existing browser windows instead of creating new ones
- Works across multiple platforms (macOS, Windows, WSL)
- Automatically positions four windows in grid layout for optimal multi-chart viewing
- All chart parameters are pre-configured for optimal viewing

### Chart Layout
The tool opens four windows in a 2x2 grid:
1. Top-Left: 3-month chart
2. Top-Right: 1-month chart with dark pools and sweeps
3. Bottom-Left: 1-month chart
4. Bottom-Right: 1-week chart with dark pools and sweeps

## RunVL Index App

For quick access to index charts (SPY and QQQ), you can:

1. Use the command line: `vl -i`
2. Use the provided RunVLIndex app in your Applications folder

### Setting up the RunVLIndex App

The repository includes a `RunVLIndex.scpt` AppleScript file that can be compiled into an application:

```bash
# Compile the script into an application
osacompile -o ~/Applications/RunVLIndex.app RunVLIndex.scpt
```

This creates a standalone app that runs the `vl -i` command when launched, displaying SPY and QQQ charts.

You can:
- Add it to your Dock for quick access
- Launch it from Spotlight
- Assign a keyboard shortcut to it using macOS Automator or third-party tools

## License

MIT 