Import-Module Microsoft.PowerShell.Utility

# Define log file
$logFile = "Rename_Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# Get current directory and confirm with user
$directory = Get-Location
Write-Host "Current Directory: $directory"
$confirm = Read-Host "Is this the correct directory? (Y/N)"
if ($confirm -ne 'Y') { exit }

# Collect all user inputs in one go
$extension = Read-Host "Enter the file extension to rename (e.g., txt, jpg, png)"
$extension = $extension -replace "^\.", ""  # Remove period if user includes it
$removePrefix = Read-Host "Enter prefix to remove (or press Enter to skip)"
$removeSuffix = Read-Host "Enter suffix to remove (or press Enter to skip)"
$addPrefix = Read-Host "Enter prefix to add (or press Enter to skip)"
$addSuffix = Read-Host "Enter suffix to add (or press Enter to skip)"
$standardizeCase = Read-Host "Standardize filenames to lowercase? (Y/N)"
$charToReplace = Read-Host "Enter character to replace (or press Enter to skip)"
$replacementChar = ""
if ($charToReplace) {
    $replacementChar = Read-Host "Enter replacement character"
}

# Display warning before confirmation
Write-Host "`nWARNING: This renaming process **CANNOT** be undone!" -ForegroundColor Red
Write-Host "Make sure you have reviewed your choices before proceeding."
Write-Host "`nReview your choices:"
Write-Host "File extension: *.$extension"
Write-Host "Remove prefix: '$removePrefix'"
Write-Host "Remove suffix: '$removeSuffix'"
Write-Host "Add prefix: '$addPrefix'"
Write-Host "Add suffix: '$addSuffix'"
Write-Host "Standardize filenames to lowercase: $standardizeCase"
Write-Host "Replace character: '$charToReplace' with '$replacementChar'"
$finalConfirm = Read-Host "`nAre you **SURE** you want to proceed? (Y/N)"
if ($finalConfirm -ne 'Y') { exit }

# Process files
$existingNames = @{}
Get-ChildItem -Path $directory -Filter "*.$extension" | Where-Object { -not $_.PSIsContainer } | ForEach-Object {
    $originalName = $_.Name
    $newName = $originalName
    
    # Skip system files
    if ($_.Attributes -match "System") {
        Write-Host "Skipping system file: $originalName"
        return
    }
    
    # Skip read-only files
    if ($_.Attributes -match "ReadOnly") {
        Write-Host "Skipping read-only file: $originalName"
        return
    }
    
    # Remove prefix if applicable
    if ($removePrefix -and $newName -match "^$removePrefix") {
        $newName = $newName -replace "^$removePrefix", ""
    }
    
    # Remove suffix if applicable
    if ($removeSuffix -and $newName -match "$removeSuffix\.$extension$") {
        $newName = $newName -replace "$removeSuffix\.$extension$", ".$extension"
    }
    
    # Add prefix
    if ($addPrefix) {
        $newName = "$addPrefix$newName"
    }
    
    # Add suffix
    if ($addSuffix) {
        $nameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($newName)
        $newName = "$nameWithoutExtension$addSuffix.$extension"
    }
    
    # Standardize capitalization
    if ($standardizeCase -eq 'Y') {
        $newName = $newName.ToLower()
    }
    
    # Replace characters
    if ($charToReplace -and $replacementChar) {
        $newName = $newName -replace [regex]::Escape($charToReplace), $replacementChar
    }
    
    # Ensure uniqueness
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($newName)
    $fileExt = [System.IO.Path]::GetExtension($newName)
    $counter = 1
    while ($existingNames.ContainsKey($newName) -or (Test-Path "$directory\$newName")) {
        $newName = "$baseName($counter)$fileExt"
        $counter++
    }
    $existingNames[$newName] = $true
    
    # Rename file if changed
    if ($newName -ne $originalName) {
        Rename-Item -Path $_.FullName -NewName $newName
        Add-Content -Path $logFile -Value "Renamed: $originalName -> $newName"
        Write-Host "Renamed: $originalName -> $newName"
    }
}

Write-Host "Renaming complete. Log saved as $logFile"
