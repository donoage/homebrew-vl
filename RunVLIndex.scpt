-- RunVLIndex.scpt
-- AppleScript to run vl in index mode (SPY and QQQ charts)

on run
    -- Get the path to the vl command
    set vlCommand to "/opt/homebrew/bin/vl"
    
    -- Run the command with index mode flag
    do shell script vlCommand & " -i"
end run 