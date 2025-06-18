@echo off
set "FOLDER_PATH=%~1"
cd /d "%FOLDER_PATH%"

for %%I in ("%FOLDER_PATH%") do set "FOLDER_NAME=%%~nxI"

git init
git add .
git commit -m "Initial commit"
gh repo create "%FOLDER_NAME%" --public --source=. --remote=origin --push

echo Done! Repo created at https://github.com/silent-syntax-official/%FOLDER_NAME%
pause
