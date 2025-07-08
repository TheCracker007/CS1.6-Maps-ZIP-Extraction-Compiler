@echo off
setlocal

set "DEST=final_output"
if not exist "%DEST%" mkdir "%DEST%"

echo 🔄 Extracting all zip files to "%DEST%"...
for %%f in (*.zip) do (
    echo ➤ Extracting: %%f
    "C:\Program Files\7-Zip\7z.exe" x "%%f" -o"%DEST%" -y
)

echo ✅ All done! Files merged into: "%DEST%"
pause
