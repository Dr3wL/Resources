# Define repository URLs and destination paths
$repos = @(
    @{ Name = "NUCCDC-tools"; Url = "https://gitlab.com/nuccdc/tools/-/archive/master/tools-master.zip"; Subfolder = "scripts/windows" },
    @{ Name = "NECCDC-2025"; Url = "https://github.com/NECCDCTeam/2025/archive/refs/heads/main.zip"; Subfolder = "Windows" }
)

$baseDestination = "C:\CCDC-Tools"

# Ensure base directory exists
if (-not (Test-Path $baseDestination)) {
    New-Item -ItemType Directory -Path $baseDestination -Force
}

# Function to download and extract a specific folder
function Download-And-Extract {
    param (
        [string]$repoName,
        [string]$repoUrl,
        [string]$subfolder
    )

    $destinationPath = "$baseDestination\$repoName"
    $zipFile = "$destinationPath.zip"

    Write-Host "`nDownloading $repoName repository..."
    Invoke-WebRequest -Uri $repoUrl -OutFile $zipFile

    Write-Host "Extracting $repoName..."
    Expand-Archive -Path $zipFile -DestinationPath $destinationPath -Force
    Remove-Item $zipFile -Force  # Clean up zip file

    # Find the extracted main folder
    $extractedFolder = Get-ChildItem -Path $destinationPath -Directory | Select-Object -First 1 -ExpandProperty FullName

    if ($extractedFolder) {
        # Check if the required subfolder exists
        $targetPath = "$extractedFolder\$subfolder"
        if (Test-Path $targetPath) {
            $finalPath = "$baseDestination\$repoName-Scripts"
            Move-Item -Path $targetPath -Destination $finalPath -Force
            Write-Host "$repoName scripts extracted to: $finalPath" -ForegroundColor Green
            
            # Cleanup unused files
            Remove-Item -Path $destinationPath -Recurse -Force
            return $finalPath
        } else {
            Write-Host "Error: Could not find the specified folder '$subfolder' in $repoName" -ForegroundColor Red
            return $null
        }
    } else {
        Write-Host "Error: Could not find extracted folder for $repoName" -ForegroundColor Red
        return $null
    }
}

# Process each repository
$windowsScriptsPaths = @()
foreach ($repo in $repos) {
    $extractedPath = Download-And-Extract -repoName $repo.Name -repoUrl $repo.Url -subfolder $repo.Subfolder
    if ($extractedPath) {
        $windowsScriptsPaths += $extractedPath
    }
}

# Unblock PowerShell scripts in both repositories
foreach ($scriptPath in $windowsScriptsPaths) {
    if (Test-Path $scriptPath) {
        Write-Host "`nUnblocking scripts in: $scriptPath"
        Get-ChildItem -Path $scriptPath -Filter "*.ps1" | Unblock-File
        Write-Host "Available scripts in ${scriptPath}:" -ForegroundColor Cyan
        Get-ChildItem -Path $scriptPath -Filter "*.ps1" | ForEach-Object { Write-Host $_.Name }
    } else {
        Write-Host "Windows scripts directory not found at: ${scriptPath}" -ForegroundColor Red
    }
}

Write-Host "`nRepositories installed successfully! You can find them in: $baseDestination" -ForegroundColor Cyan

