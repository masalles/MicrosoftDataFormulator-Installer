# Microsoft Data Formulator Installer (PowerShell Script)

> **This PowerShell script automates the installation and execution of Microsoft Data Formulator.**

![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-PowerShell-blue?style=flat&logo=windows-terminal)  
![License](https://img.shields.io/badge/License-MIT-green?style=flat)  

---

## ⚡ Overview  
This PowerShell script **automates** the setup of Microsoft Data Formulator, ensuring a smooth installation process for both backend and frontend components. If you need a quick and error-free deployment, this is your script! 🚀

### 🔧 **What It Does**  
**The script installs the necessary tools, clones the repository, sets up a Python virtual environment, installs dependencies, starts the HTML server, and runs the web interface for Microsoft Data Formulator.**

✅ **Clones the Repository** (Ensures the latest version is installed)  
✅ **Sets Up Python Virtual Environment** (Isolates dependencies)  
✅ **Installs Backend Dependencies** (Ensures the correct libraries)  
✅ **Starts Backend Server** (Runs the Python-based service)  
✅ **Installs Frontend Dependencies** (Sets up the interface)  
✅ **Starts Frontend Server** (Opens the development environment)  

---

## 🛠️ Prerequisites  
- **Administrator Privileges** 🛑 (Run as Administrator)  
- **Windows 10/11** (Tested on version 21H2+)  
- **PowerShell Execution Policy**: Ensure scripts can be executed  

---

## 🚀 How to Use  

### Right-click on "PowerShell", select "Run as Administrator", paste the command, and press "ENTER":  
```powershell
irm "https://raw.githubusercontent.com/masalles/MicrosoftDataFormulator-Installer/refs/heads/main/mdf-installer.ps1" | iex

## 🔒 Security  
Always inspect scripts before running them!  
(Download the script and save it locally before using the command):  

```powershell
Get-Content mdf-installer.ps1

If execution is blocked, temporarily allow script execution:  

```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

## ⚠️ Important Notes  
- Requires Windows 10/11 (tested on version 21H2+).  
- Backend and frontend should run in separate processes.  
- Restarting the system after installation may improve performance.  

---

## 🤝 Contributing  
Contributions are welcome! Follow these steps:  
1. Fork the repository.  
2. Create a feature branch (`git checkout -b feature/AmazingFeature`).  
3. Commit your changes (`git commit -m 'Add AmazingFeature'`).  
4. Push to the branch (`git push origin feature/AmazingFeature`).  
5. Open a Pull Request.  

---

## 📜 License  
This project is licensed under the MIT License. Feel free to use, modify, and distribute it as needed.

💡 Pro Tip: After running the script, restart your computer for best results! 🎉
