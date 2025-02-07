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
6. run information.bat or the NECCDC-2025-Scripts/inventory.ps1 + localAutoRunSchedTask
