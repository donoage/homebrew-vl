-- AppleScript to run vl command with user input
on run
	-- Ask user for ticker symbol
	set tickerSymbol to text returned of (display dialog "Enter ticker symbol:" default answer "" buttons {"Cancel", "OK"} default button "OK")
	
	-- Check if user provided a ticker
	if tickerSymbol is not "" then
		-- Run the vl command
		do shell script "/opt/homebrew/bin/vl " & tickerSymbol
	end if
end run 