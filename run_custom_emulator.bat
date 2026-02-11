@echo off
echo Connecting to emulator...
"C:\Users\45146\AppData\Local\Android\Sdk\platform-tools\adb.exe" connect 127.0.0.1:7555
timeout /t 2 /nobreak >nul
echo Running Flutter App...
flutter run
pause
