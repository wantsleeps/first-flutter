# 启动模拟器并运行 App
Write-Host "正在启动模拟器: Medium_Phone_API_36.1..." -ForegroundColor Cyan
flutter emulators --launch Medium_Phone_API_36.1

Write-Host "程序将在 5 秒后尝试运行..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host "正在运行 Flutter App..." -ForegroundColor Green
flutter run
