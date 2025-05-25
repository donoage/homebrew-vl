#!/usr/bin/env python3

import sys
import os
import platform
import subprocess
import datetime
import webbrowser
import time
import glob
import shutil
import json
import tempfile
import argparse

# VL Script Version for Windows 1.0.0 - Improved positioning and window reuse
# Based on VL Script Version 3.0.25 - Add -i flag for index mode (SPY and QQQ charts)

def print_usage():
    """Print usage instructions."""
    print("Usage: vl-windows TICKER")
    print("       vl-windows -i    (Index mode: SPY and QQQ)")
    print("Example: vl-windows AAPL")
    sys.exit(1)

def store_window_handles(window_handles, browser_name):
    """Store window handles in a temp file for future reuse."""
    try:
        # Create a consistent temp directory path
        temp_dir = os.path.join(tempfile.gettempdir(), "vl_app")
        os.makedirs(temp_dir, exist_ok=True)
        
        # Create the file path
        temp_file = os.path.join(temp_dir, "vl_windows_handles.json")
        
        # Store data with browser name and timestamp
        data = {
            "window_handles": window_handles,
            "browser": browser_name,
            "timestamp": time.time(),
            "count": len(window_handles)
        }
        
        # Write to file
        with open(temp_file, "w") as f:
            json.dump(data, f)
            
        print(f"Stored {len(window_handles)} window handles for future use")
        return True
    except Exception as e:
        print(f"Error storing window handles: {e}")
        return False

def get_stored_window_handles(max_age_seconds=3600):
    """Retrieve previously stored window handles if they exist and aren't too old."""
    try:
        # Get the temp file path
        temp_dir = os.path.join(tempfile.gettempdir(), "vl_app")
        temp_file = os.path.join(temp_dir, "vl_windows_handles.json")
        
        # Check if file exists
        if not os.path.exists(temp_file):
            return None
            
        # Read the data
        with open(temp_file, "r") as f:
            data = json.load(f)
            
        # Check if data is too old
        if time.time() - data.get("timestamp", 0) > max_age_seconds:
            print("Stored window handles are too old, will detect new ones")
            return None
            
        # Check if we have enough window handles
        window_handles = data.get("window_handles", [])
        if len(window_handles) < 4:
            print(f"Only found {len(window_handles)} stored window handles, need at least 4")
            return None
            
        print(f"Using {len(window_handles)} previously stored window handles")
        return {
            "window_handles": window_handles,
            "browser": data.get("browser", "unknown")
        }
    except Exception as e:
        print(f"Error retrieving stored window handles: {e}")
        return None

def clear_stored_window_handles():
    """Clear stored window handles when they're no longer valid."""
    try:
        temp_dir = os.path.join(tempfile.gettempdir(), "vl_app")
        temp_file = os.path.join(temp_dir, "vl_windows_handles.json")
        
        if os.path.exists(temp_file):
            os.remove(temp_file)
            print("Cleared stored window handles")
        return True
    except Exception as e:
        print(f"Error clearing window handles: {e}")
        return False

def position_windows_with_navigation(handles, urls):
    """Position windows and navigate them to the URLs - optimized for Windows."""
    try:
        # Create PowerShell script for window positioning and navigation
        ps_script = '''
        Add-Type -AssemblyName System.Windows.Forms
        
        # Get screen dimensions
        $screen = [System.Windows.Forms.Screen]::PrimaryScreen
        $screenWidth = $screen.Bounds.Width
        $screenHeight = $screen.Bounds.Height
        
        # Calculate half dimensions
        $halfWidth = $screenWidth / 2
        $halfHeight = $screenHeight / 2
        
        # Define our positions (left, top, right, bottom)
        $positions = @(
            @(0, 0, $halfWidth, $halfHeight),
            @($halfWidth, 0, $screenWidth, $halfHeight),
            @(0, $halfHeight, $halfWidth, $screenHeight),
            @($halfWidth, $halfHeight, $screenWidth, $screenHeight)
        )
        
        # Add external DLL for window manipulation
        Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        
        public class Win32 {
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
            
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
            
            [DllImport("user32.dll")]
            public static extern IntPtr GetForegroundWindow();
            
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool SetForegroundWindow(IntPtr hWnd);
            
            [DllImport("user32.dll")]
            public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
            
            [StructLayout(LayoutKind.Sequential)]
            public struct RECT {
                public int Left;
                public int Top;
                public int Right;
                public int Bottom;
            }
        }
"@
        
        # Get the window handles as integers
        $windowHandles = @($args[0].Split(',') | ForEach-Object { [System.IntPtr]::new([long]$_) })
        $urls = $args[1].Split(',')
        
        Write-Host "Positioning and navigating windows..."
        
        # Loop through handles and position them
        for ($i = 0; $i -lt [Math]::Min($windowHandles.Count, 4); $i++) {
            $handle = $windowHandles[$i]
            $pos = $positions[$i]
            
            # Calculate dimensions
            $width = $pos[2] - $pos[0]
            $height = $pos[3] - $pos[1]
            
            # Ensure window is visible and in foreground
            [Win32]::ShowWindow($handle, 9) # SW_RESTORE = 9
            [Win32]::SetForegroundWindow($handle) | Out-Null
            Start-Sleep -Milliseconds 100
            
            # Position the window
            [Win32]::MoveWindow($handle, $pos[0], $pos[1], $width, $height, $true) | Out-Null
            Start-Sleep -Milliseconds 100
        }
        
        return "success"
        '''
        
        # Create a temporary script file
        ps_file = os.path.join(tempfile.gettempdir(), f"vl_position_{time.time()}.ps1")
        with open(ps_file, 'w') as f:
            f.write(ps_script)
        
        # Convert handles to comma-separated string
        handles_str = ','.join(handles)
        urls_str = ','.join(urls)
        
        # Run PowerShell script
        cmd = ["powershell", "-ExecutionPolicy", "Bypass", "-File", ps_file, handles_str, urls_str]
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        # Clean up
        try:
            os.remove(ps_file)
        except:
            pass
        
        return "success" in result.stdout
    except Exception as e:
        print(f"Error positioning windows: {e}")
        return False

def find_and_reuse_browser_windows(browser_exe_name, urls):
    """Find existing browser windows and reuse them, or create new ones if needed."""
    try:
        # First check if we have stored window handles
        stored_data = get_stored_window_handles()
        if stored_data and stored_data.get("window_handles"):
            # Try to reuse these handles
            handles = stored_data["window_handles"]
            if position_windows_with_navigation(handles, urls):
                return True
            else:
                # If positioning failed, clear stored handles
                clear_stored_window_handles()
        
        # Script to find browser windows by process name
        ps_script = '''
        Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        using System.Collections.Generic;
        
        public class Win32 {
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool EnumWindows(EnumWindowsProc enumProc, IntPtr lParam);
            
            [DllImport("user32.dll")]
            public static extern int GetWindowTextLength(IntPtr hWnd);
            
            [DllImport("user32.dll")]
            public static extern int GetWindowText(IntPtr hWnd, System.Text.StringBuilder lpString, int nMaxCount);
            
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool IsWindowVisible(IntPtr hWnd);
            
            [DllImport("user32.dll")]
            public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
            
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
            
            public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
            
            [StructLayout(LayoutKind.Sequential)]
            public struct RECT {
                public int Left;
                public int Top;
                public int Right;
                public int Bottom;
            }
        }
"@
        
        $processName = $args[0]
        $urls = $args[1].Split(',')
        $maxWindows = 4
        
        Write-Host "Looking for existing $processName windows..."
        
        # First try to find matching processes
        $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
        
        if (-not $processes -or $processes.Count -eq 0) {
            Write-Host "No $processName processes found"
            return "no_windows_found"
        }
        
        # Find real browser windows from these processes
        $windowHandles = New-Object System.Collections.ArrayList
        
        $enumWindowsCallback = [Win32+EnumWindowsProc] {
            param(
                [IntPtr]$hwnd,
                [IntPtr]$lParam
            )
            
            # Check if window is visible
            if (-not [Win32]::IsWindowVisible($hwnd)) {
                return $true
            }
            
            # Get process ID for this window
            $processId = 0
            [Win32]::GetWindowThreadProcessId($hwnd, [ref]$processId) | Out-Null
            
            # Check if this window belongs to our processes
            $matchingProcess = $processes | Where-Object { $_.Id -eq $processId }
            if ($matchingProcess) {
                # Get window dimensions to make sure it's a real window
                $rect = New-Object Win32+RECT
                [Win32]::GetWindowRect($hwnd, [ref]$rect) | Out-Null
                
                # Check window size (skip tiny windows)
                $width = $rect.Right - $rect.Left
                $height = $rect.Bottom - $rect.Top
                
                if ($width -gt 200 -and $height -gt 200) {
                    # Get window title
                    $titleLength = [Win32]::GetWindowTextLength($hwnd)
                    if ($titleLength -gt 0) {
                        $title = New-Object System.Text.StringBuilder($titleLength + 1)
                        [Win32]::GetWindowText($hwnd, $title, $title.Capacity) | Out-Null
                        
                        # Prefer VolumeLeaders windows but accept any browser window
                        $isVolumeLeaders = $title.ToString() -like "*volumeleaders*"
                        
                        if ($isVolumeLeaders) {
                            # Add VolumeLeaders windows to the beginning
                            $windowHandles.Insert(0, $hwnd.ToString())
                        } else {
                            # Add other browser windows at the end
                            $windowHandles.Add($hwnd.ToString())
                        }
                    }
                }
            }
            
            # Continue enumeration
            return $true
        }
        
        # Enumerate all windows
        [Win32]::EnumWindows($enumWindowsCallback, [IntPtr]::Zero) | Out-Null
        
        # Check if we found enough windows
        if ($windowHandles.Count -eq 0) {
            Write-Host "No suitable browser windows found"
            return "no_windows_found"
        }
        
        # If we have too many windows, take only what we need
        if ($windowHandles.Count -gt $maxWindows) {
            $windowHandles = $windowHandles | Select-Object -First $maxWindows
        }
        
        # Return as comma-separated list
        $result = [string]::Join(",", $windowHandles)
        Write-Host "Found $($windowHandles.Count) browser window handles"
        return $result
        '''
        
        # Create a temporary script file
        ps_file = os.path.join(tempfile.gettempdir(), f"vl_find_windows_{time.time()}.ps1")
        with open(ps_file, 'w') as f:
            f.write(ps_script)
        
        # Convert URLs to comma-separated string
        urls_str = ','.join(urls)
        
        # Try Chrome first
        result = subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", ps_file, browser_exe_name, urls_str], 
                               capture_output=True, text=True)
        
        # Clean up
        try:
            os.remove(ps_file)
        except:
            pass
        
        output = result.stdout.strip()
        
        if "no_windows_found" in output:
            return []
        
        # Extract window handles from the output
        for line in output.splitlines():
            if "," in line or line.isdigit():
                handles = line.strip().split(",")
                if handles and all(h.strip().isdigit() or h.strip().startswith("0x") for h in handles):
                    # Store these handles for future use
                    store_window_handles(handles, browser_exe_name)
                    return handles
        
        return []
    except Exception as e:
        print(f"Error finding browser windows: {e}")
        return []

def launch_new_browser_windows(browser_path, urls):
    """Launch new browser windows for each URL."""
    try:
        print(f"Launching new browser windows...")
        processes = []
        handles = []
        
        # Function to find the window handle for a process
        def find_window_handle(pid, timeout=3):
            ps_script = '''
            $pid = $args[0]
            Add-Type @"
            using System;
            using System.Runtime.InteropServices;
            
            public class Win32 {
                [DllImport("user32.dll")]
                [return: MarshalAs(UnmanagedType.Bool)]
                public static extern bool EnumWindows(EnumWindowsProc enumProc, IntPtr lParam);
                
                [DllImport("user32.dll")]
                public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
                
                [DllImport("user32.dll")]
                [return: MarshalAs(UnmanagedType.Bool)]
                public static extern bool IsWindowVisible(IntPtr hWnd);
                
                [DllImport("user32.dll")]
                [return: MarshalAs(UnmanagedType.Bool)]
                public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
                
                public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
                
                [StructLayout(LayoutKind.Sequential)]
                public struct RECT {
                    public int Left;
                    public int Top;
                    public int Right;
                    public int Bottom;
                }
            }
"@
            $handle = $null
            
            $enumWindowsCallback = [Win32+EnumWindowsProc] {
                param(
                    [IntPtr]$hwnd,
                    [IntPtr]$lParam
                )
                
                if (-not [Win32]::IsWindowVisible($hwnd)) {
                    return $true
                }
                
                $processId = 0
                [Win32]::GetWindowThreadProcessId($hwnd, [ref]$processId) | Out-Null
                
                if ($processId -eq $pid) {
                    $rect = New-Object Win32+RECT
                    [Win32]::GetWindowRect($hwnd, [ref]$rect) | Out-Null
                    
                    $width = $rect.Right - $rect.Left
                    $height = $rect.Bottom - $rect.Top
                    
                    if ($width -gt 200 -and $height -gt 200) {
                        $handle = $hwnd
                        return $false  # Stop enumeration
                    }
                }
                
                return $true
            }
            
            [Win32]::EnumWindows($enumWindowsCallback, [IntPtr]::Zero) | Out-Null
            
            if ($handle) {
                return $handle.ToString()
            } else {
                return "0"
            }
            '''
            
            # Create a temporary script file
            ps_file = os.path.join(tempfile.gettempdir(), f"vl_find_handle_{time.time()}.ps1")
            with open(ps_file, 'w') as f:
                f.write(ps_script)
            
            start_time = time.time()
            while time.time() - start_time < timeout:
                try:
                    result = subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", ps_file, str(pid)], 
                                          capture_output=True, text=True)
                    handle = result.stdout.strip()
                    
                    # Clean up
                    try:
                        os.remove(ps_file)
                    except:
                        pass
                    
                    if handle and handle != "0":
                        return handle
                except:
                    pass
                
                time.sleep(0.5)
            
            # Clean up
            try:
                os.remove(ps_file)
            except:
                pass
            
            return None
        
        # Launch each window and get its handle immediately
        for url in urls:
            # Launch with --new-window to force a new window
            process = subprocess.Popen([browser_path, "--new-window", url])
            processes.append(process)
            
            # Get the window handle for this process
            handle = find_window_handle(process.pid)
            if handle:
                handles.append(handle)
            
            # Small delay between launches
            time.sleep(0.5)
        
        # Wait a moment for all windows to initialize
        time.sleep(1)
        
        # If we didn't get handles for all windows, try to find them again
        if len(handles) < len(urls):
            print(f"Found only {len(handles)} handles initially, looking for more...")
            
            # Try to find handles for the remaining processes
            for i, process in enumerate(processes):
                if i >= len(handles):
                    handle = find_window_handle(process.pid)
                    if handle:
                        handles.append(handle)
        
        print(f"Found {len(handles)} window handles out of {len(processes)} processes")
        
        # Store these handles for future use
        if len(handles) > 0:
            browser_name = "chrome" if "chrome" in browser_path.lower() else "msedge"
            store_window_handles(handles, browser_name)
        
        return handles
    except Exception as e:
        print(f"Error launching browser windows: {e}")
        return []

def find_browser_path():
    """Find the path to Chrome or Edge browser."""
    chrome_paths = [
        os.path.expandvars("%ProgramFiles%\\Google\\Chrome\\Application\\chrome.exe"),
        os.path.expandvars("%ProgramFiles(x86)%\\Google\\Chrome\\Application\\chrome.exe"),
        os.path.expandvars("%LocalAppData%\\Google\\Chrome\\Application\\chrome.exe"),
    ]
    
    for path in chrome_paths:
        if os.path.exists(path):
            return path, "chrome"
    
    edge_paths = [
        os.path.expandvars("%ProgramFiles(x86)%\\Microsoft\\Edge\\Application\\msedge.exe"),
        os.path.expandvars("%ProgramFiles%\\Microsoft\\Edge\\Application\\msedge.exe"),
    ]
    
    for path in edge_paths:
        if os.path.exists(path):
            return path, "msedge"
    
    return None, None

def main():
    """Main function."""
    # Parse command line arguments
    parser = argparse.ArgumentParser(description='View stock volume leaders with improved window handling')
    parser.add_argument('-i', '--index', action='store_true', help='Index mode: show SPY and QQQ charts')
    parser.add_argument('--force-new', action='store_true', help='Force new browser windows')
    parser.add_argument('ticker', nargs='?', help='Ticker symbol')
    
    # If no arguments provided, show usage
    if len(sys.argv) == 1:
        print_usage()
    
    args = parser.parse_args()
    
    # Get today's date in YYYY-MM-DD format
    today = datetime.date.today().strftime("%Y-%m-%d")
    print(f"Using today's date: {today}")
    
    # Calculate dates for different timeframes
    three_months_ago = (datetime.date.today() - datetime.timedelta(days=90)).strftime("%Y-%m-%d")
    one_month_ago = (datetime.date.today() - datetime.timedelta(days=30)).strftime("%Y-%m-%d")
    one_week_ago = (datetime.date.today() - datetime.timedelta(days=7)).strftime("%Y-%m-%d")
    
    # Check if we're in index mode
    if args.index:
        print("Index mode: Displaying SPY and QQQ charts")
        
        # URLs for SPY (today only)
        url1 = f"https://www.volumeleaders.com/Chart0?StartDate={today}&EndDate={today}&Ticker=SPY&MinVolume=0&MaxVolume=2000000000&MinDollars=500000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=-1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
        
        url2 = f"https://www.volumeleaders.com/Chart0?StartDate={today}&EndDate={today}&Ticker=SPY&MinVolume=0&MaxVolume=2000000000&MinDollars=6000000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
        
        # URLs for QQQ (today only)
        url3 = f"https://www.volumeleaders.com/Chart0?StartDate={today}&EndDate={today}&Ticker=QQQ&MinVolume=0&MaxVolume=2000000000&MinDollars=500000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=-1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
        
        url4 = f"https://www.volumeleaders.com/Chart0?StartDate={today}&EndDate={today}&Ticker=QQQ&MinVolume=0&MaxVolume=2000000000&MinDollars=6000000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
    
    else:
        # Regular mode with user-specified ticker
        if not args.ticker:
            print_usage()
        
        # Get the ticker and convert to uppercase
        ticker = args.ticker.upper()
        print(f"Using ticker: {ticker}")
    
        # Construct URLs with the provided ticker and dates
        url1 = f"https://www.volumeleaders.com/Chart0?StartDate={three_months_ago}&EndDate={today}&Ticker={ticker}&MinVolume=0&MaxVolume=2000000000&MinDollars=500000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=-1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
        
        url2 = f"https://www.volumeleaders.com/Chart0?StartDate={one_month_ago}&EndDate={today}&Ticker={ticker}&MinVolume=0&MaxVolume=2000000000&MinDollars=6000000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
        
        url3 = f"https://www.volumeleaders.com/Chart0?StartDate={one_month_ago}&EndDate={today}&Ticker={ticker}&MinVolume=0&MaxVolume=2000000000&MinDollars=500000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=-1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
        
        url4 = f"https://www.volumeleaders.com/Chart0?StartDate={one_week_ago}&EndDate={today}&Ticker={ticker}&MinVolume=0&MaxVolume=2000000000&MinDollars=6000000&MaxDollars=300000000000&MinPrice=0&MaxPrice=100000&DarkPools=-1&Sweeps=1&LatePrints=-1&SignaturePrints=0&VolumeProfile=0&Levels=5&TradeCount=10&VCD=0&TradeRank=-1&IncludePremarket=1&IncludeRTH=1&IncludeAH=1&IncludeOpening=1&IncludeClosing=1&IncludePhantom=1&IncludeOffsetting=1"
    
    urls = [url1, url2, url3, url4]
    
    # Find Chrome or Edge browser
    browser_path, browser_name = find_browser_path()
    
    if not browser_path:
        print("Could not find Chrome or Edge browser.")
        sys.exit(1)
    
    print(f"Using browser: {browser_path}")
    
    # Check if we should force new windows
    if args.force_new:
        print("Forcing new browser windows...")
        clear_stored_window_handles()
        handles = []
    else:
        # Try to find and reuse existing browser windows
        handles = find_and_reuse_browser_windows(browser_name, urls)
    
    # If we couldn't find any windows or not enough, launch new ones
    if not handles or len(handles) < len(urls):
        handles = launch_new_browser_windows(browser_path, urls)
    
    # Position the windows
    if handles and len(handles) > 0:
        print(f"Positioning {len(handles)} windows...")
        position_windows_with_navigation(handles, urls)
    else:
        print("Could not find or create browser windows.")
        # Fallback to simple method
        for url in urls:
            os.system(f'start "" "{url}"')
            time.sleep(0.5)

if __name__ == "__main__":
    main() 