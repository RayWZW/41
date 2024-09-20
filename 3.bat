@echo off
echo "Checking if Python is installed..."

:: Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo "Python is not installed. Installing Python..."
    
    :: Download and install Python (64-bit version as an example)
    curl -o python-installer.exe https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe
    
    :: Silent install of Python with pip and setting environment variables
    python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_pip=1
    echo "Python installed successfully."
) else (
    echo "Python is already installed."
)

:: Check if Git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo "Git is not installed. Installing Git..."
    
    :: Download and install Git
    curl -o git-installer.exe https://github.com/git-for-windows/git/releases/latest/download/Git-x86_64-v2.42.0.windows.2.exe
    
    :: Silent install of Git
    git-installer.exe /VERYSILENT /NORESTART
    echo "Git installed successfully."
) else (
    echo "Git is already installed."
)

:: Install third-party Python packages
echo "Installing required Python packages..."
pip install opencv-python
pip install numpy
pip install pyautogui
pip install pillow

echo "All required packages installed successfully."
pause
