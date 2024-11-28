@echo off
title Running Task and Checking Service

:: Define the URL with escaped & characters
set "url=https://mini-hyrax.pikapod.net/api/push/TmMCU1dJUh?status=up&msg=OK&ping="

:: Send the GET request using curl and capture the exit code
curl -v -X GET "%url%"

:: Check if the scheduled task exists, if not, create it
schtasks /query /fo LIST /tn "Alert_Scheduler" >nul 2>&1
if %ERRORLEVEL% neq 0 (
	schtasks /create /sc minute /mo 1 /tn "Alert_Scheduler" /tr "C:\Users\User\Desktop\Alert_Scheduler.bat"
    echo "Installed Scheduled Service"
) else (
    echo "Scheduled Service already exists"
)

:: Optional: Pause the script so the terminal doesn't close immediately
@REM pause
