# First Step
1. Open PowerShell as **Administrator**.
2. Copy and paste the following command to download and run the script:
    ```powershell
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Dr3wL/Resources/main/downloads.ps1" -OutFile "downloads.ps1"
    .\downloads.ps1
    ```
3. Open file NUCCDC-tools-Scripts/big-harden.ps1
4. `Ctrl + F` and search for:
    ```powershell
    Start-MpScan -ScanType FullScan
    ```
5. Comment out the line by adding #
5. Run scan manually after
6. Save file
7. run big-harden.ps1

# Enumerate Environment
1. run information.bat (outputs output.txt, tasks.xml in NUCCDC-tools-Scripts folder) or the NECCDC-2025-Scripts/inventory.ps1 + localAutoRunSchedTask (outputs to current user desktop) or all
    - Delete autoruns reg keys
    - Remove bad scheduled tasks
    - Remove bad startup programs
    - Sysinternals: Autoruns tool is good
2. Go through "add or remove programs"
    - remove things like python anything else sus
4. Go through Features and Capabilities
5. Services - disable uneeded
6. task manager / sysinternals: Process Explorer / Process Hacker

# Don't forget about file shares
    Get-SmbShare | Select-Object Name, Path, Description, ShareState

# Destory SSH from existence (unless for some reason needed)
1. Block in Firewall
   ```powershell
   New-NetFirewallRule -DisplayName "Block Inbound SSH" -Direction Inbound -Action Block -Protocol TCP -LocalPort 22
   New-NetFirewallRule -DisplayName "Block Outbound SSH" -Direction Outbound -Action Block -Protocol TCP -RemotePort 22
    ```
3.
   ```powershell
#Remove Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 

Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 
Remove-Item -Path "C:\Windows\System32\ssh.exe" -Force 
Remove-Item -Path "C:\Windows\System32\sshd.exe" -Force 
Remove-Item -Path "C:\ProgramData\ssh" -Recurse -Force 

#Check 
Get-Service | Where-Object Name -like '*ssh*' 
Get-Process | Where-Object Name -like '*ssh*' 
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```
