@echo off
setlocal

set "PROJECT_DIR=%~dp0"
if exist "%PROJECT_DIR%package.json" goto project_found
if exist "%PROJECT_DIR%tcpioneer-main\package.json" set "PROJECT_DIR=%PROJECT_DIR%tcpioneer-main\"
if exist "%PROJECT_DIR%package.json" goto project_found

echo ERROR: Could not find the TCPIOneer project.
echo Run this file from the project folder or keep it beside the tcpioneer-main folder.
pause
exit /b 1

:project_found
cd /d "%PROJECT_DIR%"

where npm >nul 2>&1
if errorlevel 1 (
    echo ERROR: npm was not found. Install Node.js from https://nodejs.org/ and try again.
    pause
    exit /b 1
)

echo Installing project dependencies...
if exist package-lock.json (
    call npm ci --no-fund --no-audit
) else (
    call npm install --no-fund --no-audit
)
if errorlevel 1 exit /b %errorlevel%

echo Building and starting TCPIOneer...
call npm start
exit /b %errorlevel%
