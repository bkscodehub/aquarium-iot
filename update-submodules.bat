@echo off
SETLOCAL

:: Check if a commit message argument is provided
IF "%~1"=="" (
    echo Error: Please provide a commit message as an argument.
    echo Usage: update_submodules.bat "Your commit message"
    exit /b 1
)

SET COMMIT_MESSAGE=%~1

echo.
echo === Updating submodule: aquarium-lighting-controller ===
cd subprojects\aquarium-lighting-controller

echo --- Checking out main branch and pulling latest changes ---
git checkout main
git pull origin main

echo --- Updating nested submodules (aquarium-iot-shared-lib inside lighting-controller) ---
git submodule update --init --recursive

cd ..\..

echo.
echo === Updating submodule: aquarium-iot-shared-lib ===
cd subprojects\aquarium-iot-shared-lib

echo --- Checking out main branch and pulling latest changes ---
git checkout main
git pull origin main

cd ..\..

echo.
echo === Staging updated submodule references ===
git add subprojects\aquarium-lighting-controller
git add subprojects\aquarium-iot-shared-lib

echo.
echo === Committing submodule updates ===
git commit -m "Update submodules: %COMMIT_MESSAGE%"

echo.
echo === Pushing to remote ===
git push origin main

echo.
echo ✅ All submodules updated and committed.
ENDLOCAL
