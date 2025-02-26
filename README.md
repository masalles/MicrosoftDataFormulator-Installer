# Microsoft Data Formulator Installer (PowerShell Script)

> **This PowerShell script automates the installation and execution of Microsoft Data Formulator.**

![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-PowerShell-blue?style=flat&logo=windows-terminal)  
![License](https://img.shields.io/badge/License-MIT-green?style=flat)  

---

## ⚡ Overview  
This PowerShell script **automates** the setup of Microsoft Data Formulator, ensuring a smooth installation process for both backend and frontend components. If you need a quick and error-free deployment, this is your script! 🚀

### 🔧 **What It Does**  
**The script installs the necessary tools, clones the repository, sets up a Python virtual environment, installs dependencies, starts the html server, and runs web interface for Microsoft Data Formulator.**

✅ **Clones the Repository** (Ensures the latest version is installed)  
✅ **Sets Up a Python Virtual Environment** (Isolates dependencies)  
✅ **Installs Backend Dependencies** (Ensures the correct libraries are installed)  
✅ **Starts the Backend Server** (Runs the Python-based service)  
✅ **Installs Frontend Dependencies** (Sets up the interface)  
✅ **Starts the Frontend Server** (Opens the development environment)  

---

## 🛠️ Prerequisites  
- **Administrator Privileges** 🛑 (Run as Administrator)  
- **Windows 10/11** (Tested on version 21H2+)  
- **PowerShell Execution Policy**: Ensure scripts can be executed  

---

## 🚀 How to Use  

### Right-click on "PowerShell," select "Run as Administrator," paste the command, and press "ENTER":  
```powershell
irm "https://raw.githubusercontent.com/masalles/francal-cs-microsoft-data-formulator-installer/refs/heads/main/mdf-installer.ps1?token=GHSAT0AAAAAAC5TNZ6KAHW46SB6TNCJWDZAZ56JBZA" | iex
