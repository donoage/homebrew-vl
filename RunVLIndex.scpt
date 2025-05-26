-- RunVLIndex.scpt
-- AppleScript to run vl in index mode (SPY and QQQ charts)

on run
    -- The most direct approach: run the command through Terminal
    tell application "Terminal"
        -- Run the vl command in index mode
        do script "/opt/homebrew/bin/vl -i"
        
        -- Wait a moment
        delay 1
        
        -- Close the terminal window
        close (first window)
    end tell
end run 