@echo off
cd /d "%USERPROFILE%\Desktop" >nul

:: === Auto-increment folder logic ===
set "baseName=new project"
set /a counter=0

:findUniqueName
if %counter%==0 (
    set "projectName=%baseName%"
) else (
    set "projectName=%baseName% %counter%"
)
if exist "%projectName%" (
    set /a counter+=1
    goto findUniqueName
)
mkdir "%projectName%" >nul
cd "%projectName%" >nul

:: === Create index.html ===
echo ^<!DOCTYPE html^> > index.html
echo ^<html lang="en"^> >> index.html
echo ^<head^> >> index.html
echo ^  ^<meta charset="UTF-8" /^> >> index.html
echo ^  ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^> >> index.html
echo ^  ^<title^>New Project^</title^> >> index.html
echo ^  ^<link rel="stylesheet" href="style.css" /^> >> index.html
echo ^  ^<script src="script.js" defer^>^</script^> >> index.html
echo ^  ^<link rel="stylesheet" href="node_modules/cct-css/cct-css.css" /^> >> index.html
echo ^</head^> >> index.html
echo ^<body^> >> index.html
echo ^  ^<h1^>Hello, World!^</h1^> >> index.html
echo ^</body^> >> index.html
echo ^</html^> >> index.html

:: === style.css ===

echo body { > style.css
echo     font-family: sans-serif; >> style.css
echo } >> style.css

:: === script.js ===
echo // Basic function template > script.js
echo function example() { >> script.js
echo     console.log("Hello from example!"); >> script.js
echo } >> script.js

:: === main.js ===
copy /Y "%USERPROFILE%\Desktop\exefolders\main.js" main.js >nul

:: === package.json ===
(
echo {
echo   "name": "changetoyourprojectname",
echo   "version": "1.0.0",
echo   "description": "My new, fancy project",
echo   "main": "main.js",
echo   "scripts": {
echo     "start": "electron .",
echo     "build": "electron-builder"
echo   },
echo   "dependencies": {
echo     "cct-css": "^1.4.0",
echo     "electron": "^24.0.0",
echo     "electron-builder": "^24.0.0"
echo   }
echo }
) > package.json

:: === Check npm installed ===
where npm >nul 2>nul || exit /b

:: === Install dependencies ===
npm install >nul
code "%USERPROFILE%\Desktop\%projectName%" >nul
echo Project "%projectName%" created successfully on your Desktop.