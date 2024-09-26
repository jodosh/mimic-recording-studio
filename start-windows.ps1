Push-Location .

function Get-Python 
{
    Write-Host "Downloading Python3.12..."
	powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 ; wget https://www.python.org/ftp/python/3.12.2/python-3.12.2.exe -outfile python-3.12.3.exe"
	   
	Write-Host "Installing Python312..."
	Start-Process "Installing Python3.12.3 ..." /wait python-3.12.2.exe  /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 TargetDir=c:\Python312
}

# Check if python is installed
$pythonVersion = & python --version 2>$null

if ($pythonVersion) {
    # Extract the version number
    $versionTr = $pythonVersion -replace 'Python ', ''
    $versionObj = New-Object -TypeName Version -ArgumentList $versionTr

    # Compare the version
    $minVersion = New-Object -TypeName Version -ArgumentList '3.10.0'

    if ($versionObj -ge $minVersion) {
        # Get the path where Python is installed
        $pythonPath = & python -c "import sys; print(sys.executable)" 2>$null

        # Write-Host "Python version $version is installed and meets the minimum requirement (3.10+)."
        # Write-Host "Python is installed at: $pythonPath"
        
        # Store Python installation path for later use
        $python3_dir = Split-Path $pythonPath
        # Write-Host "Python is installed at: $python3_dir"
    } else {
        Write-Host "Python version $version is installed but does not meet the minimum requirement (3.10+)."
        Get-Python
    }
} else {
    Write-Host "Python is not installed or not added to PATH."
    Get-Python
}

# Check if nodeJs is installed
$nodeVersion = & npm --version 2>$null


if ($nodeVersion)
{
    $minVersion = New-Object -TypeName Version -ArgumentList '10.2.0'
    $versionObj = New-Object -TypeName Version -ArgumentList $minVersion

    if ($versionObj -ge $minVersion) {
        #TODO get the PATH to nodejs
        $npmPath = (Get-Command npm).Source
        $nodejs_dir = Split-Path $npmPath
        Write-Host "NPM is at $nodejs_dir"
    } else {
        Write-Host "nodeJs version $nodeVersion is installed but does not meet the minimum requirement (10.2+)."
        ##Get-Python
        exit
    }

} else {
    Write-Host "nodeJs is not installed or not added to PATH."
    ##Get-Python
    exit
}

## TODO ensure yarn is avalaivle
Start-Process "cmd.exe" -ArgumentList "/c corepack enable" -Wait

## TODO make sure ffmpeg is avalaible

# Define the directory where the virtual environment will be created
$venvPath = ".\venv"
# Check if the venv directory exists
if (-Not (Test-Path $venvPath)) {
    # Create the virtual environment if it doesn't exist
    Write-Host "Virtual environment not found. Creating one..."
    python -m venv $venvPath
}

# Activate the virtual environment
$activateScript = Join-Path $venvPath "Scripts\Activate.ps1"

if (Test-Path $activateScript) {
    Write-Host "Activating the virtual environment..."
    & $activateScript
}

Set-Location .\backend
pip install -r requirements.txt
Start-Process -NoNewWindow python run.py

Set-Location ..\frontend
yarn install
yarn start