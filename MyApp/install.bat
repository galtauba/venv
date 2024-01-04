@echo off

cd %~dp0

python --version >nul 2>&1
if errorlevel 1 (
  echo Python is not installed on the computer.
  goto :install
) else (
  echo Python is installed on the computer.
  goto :venv
)

:install
echo Download Python...
set "url=https://www.python.org/ftp/python/3.12.1/python-3.12.1-amd64.exe"
set "file=python-3.12.1-amd64.exe"
curl -L -o "%file%" "%url%"

echo Install Python...
start /wait %file% /quiet InstallAllUsers=1 PrependPath=1
del /f %file%
"c:\Program Files\Python312\python.exe" -m venv venv
call venv\Scripts\activate.bat
pip install -r requirements.txt
call venv\Scripts\deactivate.bat
goto :exit

:venv
echo Start venv
python -m venv venv
call venv\Scripts\activate.bat
pip install -r requirements.txt
call venv\Scripts\deactivate.bat

:exit
echo End
pause
