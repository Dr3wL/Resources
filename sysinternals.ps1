# Edited from UML
# Set variables
$url = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$destination = "$env:TEMP\SysinternalsSuite.zip"
$extractPath = "$env:TEMP\SysinternalsExtracted"
$finalPath = "C:\Sysinternals-Tools"

# Define important tools
$importantTools = @(
    'procexp64.exe', 'Procmon64.exe', 'Autoruns64.exe', 'PsLoggedOn.exe', 
    'LogonSessions.exe', 'AccessChk.exe', 'Sigcheck.exe', 
    'Tcpview.exe', 'Sysmon.exe'
)

# Download Sysinternals Suite
Invoke-WebRequest -Uri $url -OutFile $destination

# Extract Sysinternals Suite
Expand-Archive -Path $destination -DestinationPath $extractPath -Force

# Create final destination folder if it doesn't exist
if (-not (Test-Path $finalPath)) {
    New-Item -Path $finalPath -ItemType Directory -Force
}

# Move only the selected tools
foreach ($tool in $importantTools) {
    $sourceFile = Join-Path -Path $extractPath -ChildPath $tool
    if (Test-Path $sourceFile) {
        Move-Item -Path $sourceFile -Destination $finalPath -Force
    }
}

# Cleanup temporary files
Remove-Item -Path $destination -Force
Remove-Item -Path $extractPath -Recurse -Force

Write-Output "Sysinternals Suite installed. Selected tools are in C:\Sysinternals-Tools."
