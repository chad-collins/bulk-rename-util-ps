# **bulk-rename-util-ps**  
bulk-rename-util-ps is a PowerShell script designed to simplify batch file renaming with flexible customization options. It allows users to modify file names by adding or removing prefixes/suffixes, replacing characters, standardizing case, and ensuring duplicate safety. The script includes built-in safeguards to prevent unintended modifications and logs all changes for reference. A test file generator is also included to help users experiment before making permanent changes. Always create backups before execution.

## **Disclaimer**  
This script is provided **"as is"** without any warranties or guarantees. The author assumes no responsibility for data loss, unintended file modifications, or any other issues that may arise from its use. **Use at your own risk**, and always create backups before executing the script.  

---

## **Testing the Script**  
Since data loss is always a possibility, it’s recommended to test the script beforehand. You can use the included **`create_test_files.ps1`** script to generate sample files for testing.  

### **Test File Generator Features:**  
- Creates a `TestFiles` folder in the current directory.  
- Generates **50 sample files** with various prefixes, suffixes, mixed cases, and special characters.  
- **Optional:** Instead of generating random filenames, it can copy existing filenames from the current directory.  

### **Running the Test File Generator:**  
```powershell
. .\create-test-files.ps1
```

---

## **File Renaming Script**  

### **Overview**  
The `rename_files.ps1` script allows users to rename files in a directory with various customization options while ensuring duplicate safety and logging changes.  

### **Features**  
✅ **Interactive Input** – Users can define:  
- File extensions to rename.  
- Prefixes and suffixes to add or remove.  
- Character replacements.  
- Filename case standardization.  

✅ **Duplicate Handling** – Ensures unique filenames by appending numbers when conflicts occur.  

✅ **Safety Measures** – The script:  
- Skips system and read-only files.  
- Prevents renaming directories.  
- Handles invalid filename characters.  

✅ **Logging** – Saves a timestamped log of all renamed files.  

---

## **Usage Instructions**  

### **1. Place the script in the target directory.**  
### **2. Run the script in PowerShell:**  
```powershell
. .\rename_files.ps1
```
### **3. Follow the interactive prompts:**  
- Confirm the target directory.  
- Specify the file extension(s) to rename.  
- Choose prefix/suffix modifications.  
- Standardize filenames to lowercase.  
- Replace specific characters.  
- Review changes before execution.  

⚠️ **Warning:** This operation **CANNOT be undone!** Always create backups before running the script.  

---

## **Requirements**  
- Windows PowerShell  
- Appropriate file permissions for renaming operations  

---

## **Additional Notes**  
- Files with identical resulting names will be auto-numbered: `(1)`, `(2)`, etc.  
- Read-only and system files will be skipped to prevent issues.  
- Always create backups before running in a production environment.  

---

## **License**  
This script is open-source and may be modified as needed.  

## **Author**  
[Chad Collins]  
