@echo off
echo "Starting Active Directory setup and configuration..."

:: Run the PowerShell script to install Active Directory
powershell.exe -ExecutionPolicy Bypass -File "C:\Qwiklabs\ADSetup\active_directory_install.ps1"

echo "Waiting for Active Directory installation and reboot..."
timeout /t 300

:: Reconnect after reboot and run the PowerShell script to configure Active Directory
powershell.exe -ExecutionPolicy Bypass -File "C:\Qwiklabs\ADSetup\configure_active_directory.ps1"

echo "Active Directory configured successfully."

:: Add user Alex
powershell.exe -Command "New-ADUser -Name 'Alex' -SamAccountName 'alex' -AccountPassword (ConvertTo-SecureString 'Password123!' -AsPlainText -Force) -Enabled $true"

:: Add group Python Developers
powershell.exe -Command "New-ADGroup -Name 'Python Developers' -GroupScope Global"

:: Add Alex to Python Developers group
powershell.exe -Command "Add-ADGroupMember -Identity 'Python Developers' -Members 'alex'"

:: Add Python Developers to Developers group
powershell.exe -Command "Add-ADGroupMember -Identity 'Developers' -Members 'Python Developers'"

:: Remove Alosha from Java Developers and add to Python Developers
powershell.exe -Command "Remove-ADGroupMember -Identity 'Java Developers' -Members 'Alosha' -Confirm:$false"
powershell.exe -Command "Add-ADGroupMember -Identity 'Python Developers' -Members 'Alosha'"

:: Create and link a new GPO for the Developers OU
powershell.exe -Command "New-GPO -Name 'New Wallpaper' | New-GPLink -Target 'OU=Developers,DC=example,DC=com'"
powershell.exe -Command "Set-GPRegistryValue -Name 'New Wallpaper' -Key 'HKCU\Control Panel\Desktop' -ValueName 'Wallpaper' -Type String -Value 'C:\Qwiklabs\wallpaper.jpg'"

echo "All tasks completed successfully."
pause
