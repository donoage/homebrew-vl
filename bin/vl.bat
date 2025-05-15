@echo off
REM VolumeLeaders Chart Launcher - Windows Batch File
REM This file should be placed in a directory that's in your PATH

REM Get the directory where this batch file is located
set SCRIPT_DIR=%~dp0

REM Call the Python script with all arguments
python "%SCRIPT_DIR%vl" %*

REM If Python command fails, try with python3
if %ERRORLEVEL% NEQ 0 (
    python3 "%SCRIPT_DIR%vl" %*
) 