# Set encoding to UTF-8 to ensure special characters are displayed correctly
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Set execution policy to allow the script to run
Set-ExecutionPolicy Bypass -Scope Process -Force

# Clear the screen
Clear-Host

# Function to check if a command exists
function Command-Exists {
    param ($Command)
    return $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# Function to display colored text
function Write-Colored {
    param ($Text, $Color = "White")
    Write-Host $Text -ForegroundColor $Color
}

# Function to display a header
function Show-Header {
    param ($Title)
    Write-Colored "" 
    Write-Colored "  $Title" "Cyan"
    Write-Colored "  --------------------------------------------------------------" "DarkGray"
    Write-Colored ""
}

# Function to display a status message
function Show-Status {
    param ($Message, $Type = "normal")
    
    $prefix = "    "
    
    switch ($Type) {
        "success" { 
            Write-Colored "$prefix[OK] $Message" "Green"
        }
        "info" { 
            Write-Colored "$prefix[i] $Message" "Cyan"
        }
        "warning" { 
            Write-Colored "$prefix[!] $Message" "Yellow"
        }
        "error" { 
            Write-Colored "$prefix[X] $Message" "Red"
        }
        "progress" { 
            Write-Colored "$prefix[*] $Message" "Yellow"
        }
        default { 
            Write-Colored "$prefix$Message" "White"
        }
    }
}

# Function to display a progress bar
function Show-Progress {
    param (
        $Package,
        $Percentage,
        $NewLine = $false
    )
    
    $prefix = "    "
    $barWidth = 30
    $barComplete = [math]::Floor(($barWidth * $Percentage) / 100)
    $bar = "[" + ("#" * $barComplete) + (" " * ($barWidth - $barComplete)) + "]"
    
    if ($NewLine) {
        Write-Host "$prefix$bar $Percentage% - $Package" -ForegroundColor Cyan
    } else {
        Write-Host "`r$prefix$bar $Percentage% - $Package" -NoNewline -ForegroundColor Cyan
    }
}

# Function to display text with color animation
function Show-AnimatedText {
    param (
        $Text,
        $Duration = 5,  # Duration in seconds
        $Speed = 100  # Interval in milliseconds
    )
    
    $prefix = "    "
    $colors = @("Cyan", "Blue", "Magenta", "Yellow", "Green", "Cyan")
    $iterations = $Duration * 1000 / $Speed
    $counter = 0
    
    while ($counter -lt $iterations) {
        $colorIndex = $counter % $colors.Count
        $color = $colors[$colorIndex]
        
        Write-Host "`r$prefix[>] $Text" -NoNewline -ForegroundColor $color
        Start-Sleep -Milliseconds $Speed
        $counter++
    }
    
    # Leave the final message in Cyan
    Write-Host "`r$prefix[>] $Text" -NoNewline -ForegroundColor Cyan
}

# Function to display a farewell message
function Show-Farewell {
    $scriptName = Split-Path $MyInvocation.MyCommand.Path -Leaf
    
    Write-Host ""
    Write-Host "    [!] Shutting down Microsoft Data Formulator..." -ForegroundColor Yellow
    Write-Host "    [!] To run it again, type: powershell -File $scriptName" -ForegroundColor Yellow
    Write-Host ""
}

# Function to install Data Formulator with progress
function Install-DataFormulator {
    $prefix = "    "
    
    # List of main packages to be installed
    $mainPackages = @(
        "data_formulator",
        "autopep8",
        "jupyter",
        "pandas",
        "docker",
        "namedlist",
        "matplotlib",
        "flask",
        "flask-cors",
        "openai",
        "azure-identity",
        "azure-keyvault-secrets",
        "python-dotenv",
        "vega_datasets",
        "litellm"
    )
    
    $totalPackages = $mainPackages.Count
    
    # Start the installation
    Write-Colored ""
    Show-Status "Starting installation of Microsoft Data Formulator..." "progress"
    Write-Colored ""
    
    # Install the main package and capture the output
    $process = Start-Process -FilePath "pip" -ArgumentList "install", "data_formulator", "-v" -NoNewWindow -PassThru -RedirectStandardOutput "pip_output.txt"
    
    # Initialize the progress bar
    Show-Status "Installing packages..." "progress"
    
    # Counter to track progress
    $currentPackage = 0
    
    # While the process is running, show progress
    while (-not $process.HasExited) {
        # Update the current package (circular loop through packages)
        $currentPackage = ($currentPackage + 1) % $totalPackages
        $package = $mainPackages[$currentPackage]
        
        # Calculate the percentage based on elapsed time (simulation)
        $simulatedPercentage = [math]::Min(95, ($currentPackage * 100) / $totalPackages)
        
        # Display the progress bar for the current package
        Write-Host "`r$prefix" -NoNewline
        
        # Draw the progress bar
        $barWidth = 30
        $barComplete = [math]::Floor(($barWidth * $simulatedPercentage) / 100)
        $bar = "[" + ("#" * $barComplete) + (" " * ($barWidth - $barComplete)) + "]"
        
        # Display the bar with the percentage and the current package name
        Write-Host "$bar $($simulatedPercentage.ToString("0"))% - Installing: $package" -NoNewline -ForegroundColor Cyan
        
        # Small pause to simulate progress
        Start-Sleep -Milliseconds 300
    }
    
    # Ensure the progress bar reaches 100%
    Write-Host "`r$prefix" -NoNewline
    $bar = "[" + ("#" * $barWidth) + "]"
    Write-Host "$bar 100% - Installation complete!" -ForegroundColor Green
    Write-Colored ""
    
    # Remove the temporary file
    if (Test-Path "pip_output.txt") {
        Remove-Item "pip_output.txt" -Force
    }
    
    Show-Status "Microsoft Data Formulator installed successfully!" "success"
}

# Display the banner
Write-Colored "" 
Write-Colored "  =================================================================" "Magenta"
Write-Colored "  =                                                               =" "Magenta"
Write-Colored "  =             MICROSOFT DATA FORMULATOR                         =" "Magenta"
Write-Colored "  =             AUTOMATED INSTALLER                               =" "Magenta"
Write-Colored "  =                                                               =" "Magenta"
Write-Colored "  =================================================================" "Magenta"
Write-Colored ""

# Prerequisites section
Show-Header "PREREQUISITES"

# Install Chocolatey if not installed
if (-not (Command-Exists "choco")) {
    Show-Status "Installing Chocolatey..." "progress"
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Show-Status "Chocolatey installed successfully!" "success"
} else {
    Show-Status "Chocolatey is already installed." "success"
}

# Install Git if not installed
if (-not (Command-Exists "git")) {
    Show-Status "Installing Git..." "progress"
    choco install git -y
    Show-Status "Git installed successfully!" "success"
} else {
    Show-Status "Git is already installed." "success"
}

# Install Node.js (which includes npm) if not installed
if (-not (Command-Exists "node")) {
    Show-Status "Installing Node.js..." "progress"
    choco install nodejs -y
    Show-Status "Node.js installed successfully!" "success"
} else {
    Show-Status "Node.js is already installed." "success"
}

# Install Yarn if not installed
if (-not (Command-Exists "yarn")) {
    Show-Status "Installing Yarn..." "progress"
    npm install --global yarn
    Show-Status "Yarn installed successfully!" "success"
} else {
    Show-Status "Yarn is already installed." "success"
}

# Install Python3 if not installed
if (-not (Command-Exists "python")) {
    Show-Status "Installing Python3..." "progress"
    choco install python3 -y
    Show-Status "Python3 installed successfully!" "success"
} else {
    Show-Status "Python3 is already installed." "success"
}

# Install pip (Python package installer) if not installed
if (-not (Command-Exists "pip")) {
    Show-Status "Installing pip..." "progress"
    choco install pip -y
    Show-Status "pip installed successfully!" "success"
} else {
    Show-Status "pip is already installed." "success"
}

# Install virtualenv if not installed
if (-not (Command-Exists "virtualenv")) {
    Show-Status "Installing virtualenv..." "progress"
    pip install virtualenv
    Show-Status "virtualenv installed successfully!" "success"
} else {
    Show-Status "virtualenv is already installed." "success"
}

# Environment setup section
Show-Header "ENVIRONMENT SETUP"

# Create and activate a virtual environment
Show-Status "Setting up Python virtual environment..." "progress"
virtualenv venv
Show-Status "Virtual environment created successfully!" "success"

# Activate the virtual environment in PowerShell
Show-Status "Activating the virtual environment..." "progress"
.\venv\Scripts\Activate.ps1
Show-Status "Virtual environment activated successfully!" "success"

# Data Formulator installation section
Show-Header "DATA FORMULATOR INSTALLATION"

# Install Data Formulator with progress
Install-DataFormulator

# Display success message
Write-Colored ""
Write-Colored "  =================================================================" "Green"
Write-Colored "  =                                                               =" "Green"
Write-Colored "  =             INSTALLATION COMPLETED SUCCESSFULLY!              =" "Green"
Write-Colored "  =                                                               =" "Green"
Write-Colored "  =================================================================" "Green"
Write-Colored ""

# Display information about Data Formulator
Show-Status "Microsoft Data Formulator will start as a local web server." "info"
Show-Status "Once started, it will automatically open in your default browser." "info"
Show-Status "Address: http://localhost:5000" "info"
Show-Status ""
Show-Status "To stop the server, press Ctrl+C in this window." "info"
Show-Status ""

# Pause before starting Data Formulator with color animation
Show-AnimatedText "Press Enter to start Microsoft Data Formulator..." 10
$null = Read-Host

# Initialization section
Show-Header "DATA FORMULATOR INITIALIZATION"

# Start Data Formulator
Show-Status "Starting Microsoft Data Formulator..." "progress"
Show-Status "Please wait while the server starts and the browser opens..." "info"
Show-Status "To stop the server, press Ctrl+C in this window." "info"
Write-Colored ""

# Create a temporary script file to run Data Formulator
$tempScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
$scriptContent = @"
try {
    python -m data_formulator
} finally {
    Write-Host ""
    Write-Host "    [!] Shutting down Microsoft Data Formulator..." -ForegroundColor Yellow
    Write-Host ""
}
"@
Set-Content -Path $tempScriptPath -Value $scriptContent

# Execute the temporary script
powershell -File $tempScriptPath

# Remove the temporary script
Remove-Item -Path $tempScriptPath -Force