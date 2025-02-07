# First Step
1. Open PowerShell as **Administrator**.
2. Copy and paste the following command to download and run the script:
    ```powershell
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Dr3wL/Resources/main/downloads.ps1" -OutFile "downloads.ps1"
    .\downloads.ps1
    ```
3. Open file NUCCDC-tools-Scripts/big-harden.ps1 in notepad
4. `Ctrl + F` and search for:
```powershell
Start-MpScan -ScanType FullScan
```
5. Comment out the line by adding #
6. Save file
7. run big-harden.ps1
8. Run scan manually after


# Enumerate Environment
1. run information.bat (outputs output.txt, tasks.xml in NUCCDC-tools-Scripts folder) or the NECCDC-2025-Scripts/inventory.ps1 + localAutoRunSchedTask (outputs to current user desktop) or all
    - Delete autoruns reg keys
    - Remove bad scheduled tasks
    - Remove bad startup programs
    - Sysinternals: Autoruns tool is good
2. Go through "add or remove programs"
    - remove things like python anything else sus
4. Go through Features and Capabilities
5. Services - disable unneeded
6. task manager / sysinternals: Process Explorer / Process Hacker
7. Windows Defender Exclusions
   - If you can not remove them its because of registry keys or group policy
```[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths]```
```[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Extensions]```
```[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Processes]```


# File shares
    Get-SmbShare | Select-Object Name, Path, Description, ShareState
    

# Destory SSH from existence (unless for some reason needed)
1. Block in Firewall
```powershell
New-NetFirewallRule -DisplayName "Block Inbound SSH" -Direction Inbound -Action Block -Protocol TCP -LocalPort 22
New-NetFirewallRule -DisplayName "Block Outbound SSH" -Direction Outbound -Action Block -Protocol TCP -RemotePort 22
```
2. NECCDC-2025-scripts/removeSSH.ps1
3. services - look for openssh, sshd, ssh


# Further Hardening
1. Know what your running... Its well commented
2. winrm has been scored in the past, if it breaks look back at harden_winrm.ps1
3. Runs all scripts in NUCCDC-tools-Scripts\hardening_scripts
```powershell
Get-ChildItem -Path "C:\CCDC-Tools\NUCCDC-tools-Scripts\hardening_scripts" -Filter "*.ps1" | ForEach-Object { & $_.FullName }
```


# Install Sysinternal Tools
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Dr3wL/Resources/main/sysinternals.ps1" -OutFile "downloads.ps1"
.\downloads.ps1
```
1. **procexp64**: Advanced task manager.
2. **procmon64**: Real-time monitoring tool that tracks file system, registry, and process/thread activity.
3. **Autoruns64**: Displays all programs configured to run at startup, including those in registry keys and scheduled tasks.
4. **Tcpview**: Displays active network connections.
5. **AccessChk.exe**: Examines permissions for files, registry keys, and services, allowing you to see what users/groups have access to certain objects.
6. **Sigcheck**: Verifies digital signatures of files to detect unsigned or potentially malicious executables. Also checks file version info and VirusTotal integration.
8. **LogonSessions.exe**: Shows active logon sessions and their associated processes. Helps in identifying unauthorized access.
9. **PsLoggedOn.exe**: Lists users currently logged into a machine, either locally or remotely. Useful for auditing and security investigations.


# Things to Remember
1. ```quser``` often ```quser /server:<server-name>```
    - ```logoff <id>```
2. backups are good
3. Remember what is scored / if its http or https
4. Idk what a winrm connection looks like




