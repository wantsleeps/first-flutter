@echo off
echo Connecting to emulator...
adb connect 127.0.0.1:5555
timeout /t 2 /nobreak >nul
echo Running Flutter App...
flutter run
pause
