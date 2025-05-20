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
git commit -m "Update submodules: aquarium-lighting-controller & aquarium-iot-shared-lib to latest main"

echo.
echo === Pushing to remote ===
git push origin main

echo.
echo ✅ All submodules updated and committed.
ENDLOCAL
