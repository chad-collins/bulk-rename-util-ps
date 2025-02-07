# Define the test folder
$testFolder = "$PWD\TestFiles"
if (-Not (Test-Path $testFolder)) {
    New-Item -ItemType Directory -Path $testFolder | Out-Null
}

# Check if there are existing files in the current directory
$existingNames = Get-ChildItem -Path $PWD -File | Select-Object -ExpandProperty Name

# Ask user whether to use existing filenames or generate random ones
$useExistingNames = "N"
if ($existingNames.Count -gt 0) {
    $useExistingNames = Read-Host "Found existing files in this directory. Use their names instead of generating random ones? (Y/N)"
}

# Define random prefixes, suffixes, and names
$prefixes = @("temp_", "backup_", "copy_", "draft_", "old_", "file_", "v1_", "test_")
$suffixes = @("_final", "_edit", "_backup", "_copy", "_old", "_draft", "_v2", "_new")
$randomNames = @("report", "notes", "document", "data", "log", "summary", "info", "details", "record", "entry")
$specialChars = @("-", "_", " ", "(", ")")

# Generate 50 test files
for ($i = 1; $i -le 50; $i++) {
    if ($useExistingNames -eq "Y" -and $existingNames.Count -gt 0) {
        $fileName = $existingNames | Get-Random
    } else {
        $prefix = $prefixes | Get-Random
        $suffix = $suffixes | Get-Random
        $name = $randomNames | Get-Random
        $randomNumber = Get-Random -Minimum 1 -Maximum 999
        $specialChar = $specialChars | Get-Random
        $mixedCaseName = ($name.Substring(0,1).ToUpper() + $name.Substring(1).ToLower())

        # Construct the filename
        $fileName = "$prefix$specialChar$mixedCaseName$specialChar$randomNumber$suffix.txt"
    }
    
    # Create an empty file
    New-Item -ItemType File -Path "$testFolder\$fileName" | Out-Null
}

Write-Host "Test files created in: $testFolder"
