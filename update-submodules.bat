@echo off
SETLOCAL

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
for /f "tokens=2 delims==" %A in ('wmic os get localdatetime /value') do set datetime=%A
set datetime=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%-%datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%
echo %datetime%
git commit -m "Update submodules: to latest main %datetime%"

echo.
echo === Pushing to remote ===
git push origin main

echo.
echo ✅ All submodules updated and committed.
ENDLOCAL
