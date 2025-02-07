# Rename Script

## Overview
This PowerShell script allows users to rename files in a directory with various customization options, ensuring duplicate safety and logging changes.

## Features
- **Interactive Input**: Users can specify file extensions, prefixes, suffixes, character replacements, and case standardization.
- **Duplicate-Safe Logic**: Ensures unique filenames by appending numbers when conflicts occur.
- **Safety Checks**:
  - Skips system and read-only files.
  - Prevents renaming directories.
  - Handles invalid characters.
- **Logging**: Saves a record of renamed files to a timestamped log.

## Usage
### 1. Place the script in the target directory.
### 2. Run the script in PowerShell:
```powershell
.
rename_files.ps1
```
### 3. Follow the interactive prompts:
- Confirm the directory.
- Specify the file extension to rename.
- Choose prefix/suffix removal or addition.
- Standardize filenames to lowercase.
- Replace specific characters.
- Review changes before execution.

## Warning
⚠️ **This operation CANNOT be undone!** Please make backups before running this script.

## Requirements
- Windows PowerShell
- Appropriate permissions to rename files in the target directory.

## Notes
- Files with identical resulting names will be appended with a number `(1), (2), etc.`.
- Read-only and system files will be skipped to prevent issues.
- Ensure backups before running in production environments.

## Bonus: Test File Generator
If you'd like to test this script, you can use the included **Test File Maker** script.

### Test File Maker Features:
- Creates a `TestFiles` folder in the current directory.
- Generates **50 sample files** with various prefixes, suffixes, mixed cases, and special characters.
- **Option to copy filenames** from the current directory instead of generating random ones.

### Running the Test File Maker:
```powershell
.	create-test-files.ps1
```

## License
This script is open-source and can be modified as needed.

## Author
[Chad Collins]

