-- RunVLIndex.scpt
-- AppleScript to run vl command in index mode (SPY and QQQ)

on run
	-- Run the vl command with the index flag
	do shell script "/opt/homebrew/bin/vl -i"
end run 