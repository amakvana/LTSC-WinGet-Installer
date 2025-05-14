@echo off & setlocal & title %~nx0
if /i not "%~1"=="am_admin" powershell start -verb runas '%0' am_admin & exit /b
where /q winget || (
    call :setupWinGet
    start "%~nx0" "%~0" am_admin & exit /b
)

set "_apps=7zip.7zip Microsoft.Edge"
for %%a in (%_apps%) do winget install "%%~a" --force --silent --accept-source-agreements --accept-package-agreements
exit 

REM ========== FUNCTIONS ==========
:setupWinGet
    setlocal 
    set "_tmp=%TEMP%\%RANDOM%%RANDOM%"
    set "_os=x64"
    if /i "%PROCESSOR_ARCHITECTURE%"=="x86" if /i "%PROCESSOR_ARCHITEW6432%"=="" set "_os=x86"
    >nul 2>&1 mkdir "%_tmp%"
    echo(Downloading WinGet ...
    cd /d "%_tmp%"
    for /f "tokens=2 delims= " %%a in ('curl -sL https://api.github.com/repos/microsoft/winget-cli/releases/latest ^| find /i "browser_download_url"') do curl -sL %%~a -o "%%~nxa"
    for /f "delims=" %%a in ('dir /b *.zip') do tar -xf "%%~a"
    echo(Installing WinGet ...
    for %%a in (*.xml) do set "_lic=%%~dpnxa"
    for %%a in (*.msixbundle) do set "_pkg=%%~dpnxa"
    powershell Add-AppxPackage -Path "%_os%\*.appx"
    powershell Add-AppxPackage -Path "%_pkg%"
    powershell Add-AppxProvisionedPackage -Online -PackagePath "%_pkg%" -LicensePath "%_lic%"
    powershell Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
    powershell Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.Winget.Source_8wekyb3d8bbwe
    >nul 2>&1 timeout /t 01 /nobreak 
    cd /d "%~dp0"
    2>nul rmdir /s /q "%_tmp%" 
exit /b 
