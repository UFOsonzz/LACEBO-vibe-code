@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"

echo ==============================================
echo  LACEBO - One Click Dev Startup
echo ==============================================
echo.

where npm >nul 2>&1
if errorlevel 1 (
  echo [ERROR] npm was not found. Please install Node.js first.
  pause
  exit /b 1
)

if not exist "%ROOT%server\package.json" (
  echo [ERROR] Cannot find server\package.json
  pause
  exit /b 1
)

if not exist "%ROOT%client\package.json" (
  echo [ERROR] Cannot find client\package.json
  pause
  exit /b 1
)

echo [1/4] Checking backend dependencies...
if not exist "%ROOT%server\node_modules" (
  echo      Installing backend packages...
  pushd "%ROOT%server"
  call npm install
  if errorlevel 1 (
    echo [ERROR] Backend npm install failed.
    popd
    pause
    exit /b 1
  )
  popd
)

echo [2/4] Checking frontend dependencies...
if not exist "%ROOT%client\node_modules" (
  echo      Installing frontend packages...
  pushd "%ROOT%client"
  call npm install
  if errorlevel 1 (
    echo [ERROR] Frontend npm install failed.
    popd
    pause
    exit /b 1
  )
  popd
)

echo [3/4] Starting backend on http://localhost:3001 ...
start "LACEBO Backend" cmd /k "cd /d ""%ROOT%server"" && npm run dev"

echo [4/4] Starting frontend on http://localhost:5173 ...
start "LACEBO Frontend" cmd /k "cd /d ""%ROOT%client"" && npm run dev"

echo.
echo App is starting. Opening browser...
start "" "http://localhost:5173"
echo.
echo Done. Keep both terminal windows open while developing.

endlocal
