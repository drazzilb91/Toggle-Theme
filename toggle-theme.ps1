# Powershell script to toggle between light and dark theme in Windows 11
# Author: @drazzilb91
# Date: 2023-06-22

# User variables for light and dark theme file names
$lightName = "aero.theme"
$darkName = "dark.theme"
$defaultWindowsThemeFolder = "C:\Windows\Resources\Themes\"
$lightThemeFileName = $defaultWindowsThemeFolder + $lightName
$darkThemeFileName = $defaultWindowsThemeFolder + $darkName

# Get current theme
$isLightThemeEnabled = (Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme).AppsUseLightTheme

# Get theme folder path and fileName
$themeFolder = (Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\" -Name CurrentTheme).CurrentTheme

# Use theme name to check whether current theme is light or dark and then toggle to the opposite.
if ($isLightThemeEnabled -eq 1) {
    Write-Host "Light theme is active. Switching to dark theme located at $darkThemeFileName."
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\" /v CurrentTheme /t REG_SZ /d $darkThemeFileName /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
    Write-Host "Dark theme is now active."
} else  {
    Write-Host "Dark theme is active. Switching to light theme located at $lightThemeFileName."
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\" /v CurrentTheme /t REG_SZ /d $lightThemeFileName /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f
}
