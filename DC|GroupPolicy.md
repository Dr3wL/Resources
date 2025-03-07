# Domain
1. **create new domain admin**
2. **add domain admins to protected users**
Kick everyone but yourself and blackteam out of the following:
  - Domain admins
  - Enterprise admins
  - Schema admins
  - Group Policy Creator Owners
  - DNS Admins
  - Cert Publishers

2. Idk
  - Enterprise Key Admins
  - Key Admins
  - RAS and IAS Servers (computes, remote access services?)

# Potentially make it harder to get restart cycled
1. Disable Shutdown & Reboot for Non-Admins
  - Modify Group Policy:Restrict ```Shut down the system``` to only essential accounts.
```plaintext
gpedit.msc -> Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> User Rights Assignment
 ```
2. Restrict Shut down the system to only essential accounts.
```plaintext
Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> Security Options -> Shutdown: Allow system to be shut down without having to log on
```
3. Registry key to remove shutdown/restart button on login screen
```powershell
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ShutdownWithoutLogon /t REG_DWORD /d 0 /f
```
# Dump all Current GPOs
```powershell
Get-GPOReport -All -ReportType Html -Path "C:\Temp\All-GPOs.html"
```

2. GPOZaurr
https://github.com/EvotecIT/GPOZaurr
  - https://evotec.xyz/the-only-command-you-will-ever-need-to-understand-and-fix-your-group-policies-gpo/

# SPN Query for accounts vulnerable to Kerberoasting
```powershell
Import-Module ActiveDirectory

# Search for all users with an SPN set
Get-ADUser -Filter "ServicePrincipalName -like '*'" -Properties ServicePrincipalName | 
Select-Object Name, SamAccountName, ServicePrincipalName
```



