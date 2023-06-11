# Powershell script to toggle between light and dark theme in Windows 11
# Author: @drazzilb91
# Date: 2023-03-18

# User variables for light and dark theme file names
$lightName = "MMLight.theme"
$darkName = "MMDark.theme"

# Get current theme path
$currentThemePath = (Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\" -Name CurrentTheme).CurrentTheme

# Get theme folder path and fileName
$folderPath = Split-Path -Path $currentThemePath -Parent
$currentFileName = Split-Path -Path $currentThemePath -Leaf
$darkPath = $folderPath + "\" + $darkName
$lightPath = $folderPath + "\" + $lightName

# Use theme name to check whether current theme is light or dark and then toggle to the opposite.
if ($currentFileName -eq $darkName) {
    echo "Dark theme. Switching to light theme located at $lightPath."
    Start $lightPath
} elseif ($currentFileName -eq $lightName) {
    echo "Light theme. Switching to dark theme located at $darkPath."
    Start $darkPath
}
else {
    echo "Something went wrong. Current theme is not an exact match to the provided light or dark theme file names. Exiting."
    exit
}
