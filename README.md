# LTSC-WinGet-Installer

![Platform](https://img.shields.io/badge/platform-Windows%20LTSC-orange)

A simple **Batch script** to enable and install **WinGet (Windows Package Manager)** on unsupported Windows **LTSC** editions. It fetches the latest WinGet release from Microsoft's GitHub and handles installation automatically.

---

## 🛠 Features

- Automatically elevates to Admin
- Detects if `winget` is missing
- Downloads the latest **WinGet release** directly from GitHub
- Installs required components via `Add-AppxPackage`
- Installs a few useful default apps (e.g. **7-Zip**, **Microsoft Edge**)
- Cleans up after itself

---

## 🚀 How to Use

1. **Download the script**:
   - [install-winget.bat](https://github.com/amakvana/LTSC-WinGet-Installer/raw/main/install-winget.bat)

2. **Right-click** → **Run as Administrator**

Alternatively, run from Git:

```cmd
git clone https://github.com/amakvana/LTSC-WinGet-Installer.git
cd LTSC-WinGet-Installer
install-winget.bat
